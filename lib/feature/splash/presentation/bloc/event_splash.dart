part of 'bloc_splash.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class GetKeyEvent extends SplashEvent {
  final bool refresh;

  const GetKeyEvent({this.refresh = false});

  @override
  List<Object> get props => [refresh];
}