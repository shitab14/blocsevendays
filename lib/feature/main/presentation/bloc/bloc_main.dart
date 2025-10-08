import 'package:blocsevendays/core/localdata/sharedpreference_helper.dart';
import 'package:dart_either/dart_either.dart';
import '../../domain/article_entity.dart';
import '../../domain/get_news_usecase.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/utils/constants.dart';

part 'event_main.dart';
part 'state_main.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetNewsUseCase _getNews;

  MainBloc({
    required GetNewsUseCase getNewsUseCase,
  }) : _getNews = getNewsUseCase,
        super(const MainState()) {
    on<GetNewsEvent>(_onGetNewsEvent);
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
      "tesla",
      "2025-09-08",
      "publishedAt",
      key ?? "",

    );

    result.fold(
      ifLeft: (AppException failure) {
        emit(state.copyWith(
          status: MainStatus.failure,
          errorMessage: failure.message,
        ));
      }, ifRight: (List<ArticleEntity> articles) {
      emit(state.copyWith(
        status: MainStatus.success,
        articles: articles,
        errorMessage: null,
      ));
    },
    );
  }

}