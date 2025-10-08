import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/get_key_usecase.dart';
import '../../domain/key_entity.dart';

part 'event_splash.dart';
part 'state_splash.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetKeyUseCase _getKey;

  SplashBloc({
    required GetKeyUseCase getKeyUseCase,
  })  : _getKey = getKeyUseCase,
        super(const SplashState()) {
    on<GetKeyEvent>(_onGetKeyEvent);
  }

  Future<void> _onGetKeyEvent(
      GetKeyEvent event,
      Emitter<SplashState> emit,
      ) async {
    if (event.refresh) {
      emit(state.copyWith(
        status: SplashStatus.loading,
      ));
    } else {
      emit(state.copyWith(status: SplashStatus.failure));
    }

    final result = await _getKey();

    result.fold(
      ifLeft: (AppException failure) {
        emit(state.copyWith(
          status: SplashStatus.failure,
          errorMessage: failure.message,
        ));
      }, ifRight: (KeyEntity key) {
      emit(state.copyWith(
        status: SplashStatus.success,
        key: key.key,
        errorMessage: null,
      ));
    },
    );
  }

}