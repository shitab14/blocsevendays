import 'package:blocsevendays/core/localdata/sharedpreference_helper.dart';
import 'package:dart_either/dart_either.dart';
import '../../../../core/utils/date_time_util.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/article_entity.dart';
import '../../domain/get_news_usecase.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/utils/constants.dart';

part 'event_main.dart';
part 'state_main.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetNewsUseCase _getNews;

  MainBloc({
    required GetNewsUseCase getNewsUseCase,
  }) : _getNews = getNewsUseCase,
        super(MainState(
        currentWeekStart: DateTimeUtil.getWeekStart(DateTime.now()),
      )) {
    on<GetNewsEvent>(_onGetNewsEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<ChangeWeekEvent>(_onChangeWeekEvent);
  }

  Future<void> _onChangeWeekEvent(
      ChangeWeekEvent event,
      Emitter<MainState> emit,
      ) async {
    // Calculate new week start based on direction
    final weeksToAdd = event.direction;
    final newWeekStart = state.currentWeekStart.add(Duration(days: weeksToAdd * 7));

    // Ensure the new week start is always a Saturday
    final adjustedWeekStart = DateTimeUtil.getWeekStart(newWeekStart);

    emit(state.copyWith(
      currentWeekStart: adjustedWeekStart,
    ));
  }

  Future<void> _onSelectDateEvent(
      SelectDateEvent event,
      Emitter<MainState> emit,
      ) async {
    emit(state.copyWith(
      selectedDate: DateTimeUtil.formatDateForApi(event.selectedDate),
    ));
  }

  Future<void> _onGetNewsEvent(
      GetNewsEvent event,
      Emitter<MainState> emit,
      ) async {

    emit(state.copyWith(
      status: MainStatus.loading,
    ));

    final key = await SharedPreferencesHelper.getValue<String>(AppConstants.newsKey);

    final result = await _getNews(
      event.q,
      event.from,
      event.sortBy,
      key ?? "",

    );

    result.fold(
      ifLeft: (AppException failure) {
        emit(state.copyWith(
          status: MainStatus.failure,
          errorMessage: failure.message,
        ));
      },

      ifRight: (List<ArticleEntity> articles) {
        // AppLogger.debug("SHITAB: bloc_main:"+ articles.length.toString());

        emit(state.copyWith(
        status: MainStatus.success,
        articles: articles,
        errorMessage: "",
      ));
    },
    );
  }

}