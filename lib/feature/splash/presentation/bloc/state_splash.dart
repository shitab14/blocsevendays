part of 'bloc_splash.dart';

enum SplashStatus { initial, loading, success, failure }

class SplashState extends Equatable {
  final SplashStatus status;
  final String key;
  final String? errorMessage;

  const SplashState({
    this.status = SplashStatus.initial,
    this.key = "",
    this.errorMessage,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? key,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      key: key ?? this.key,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    key,
    errorMessage,
  ];
}