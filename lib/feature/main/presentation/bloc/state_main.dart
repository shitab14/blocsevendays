part of 'bloc_main.dart';

enum MainStatus { initial, loading, success, failure }

class MainState extends Equatable {
  final MainStatus status;
  final List<ArticleEntity> articles;
  final String? errorMessage;

  const MainState({
    this.status = MainStatus.initial,
    this.articles = const [],
    this.errorMessage,
  });

  MainState copyWith({
    MainStatus? status,
    List<ArticleEntity>? articles,
    String? errorMessage,
  }) {
    return MainState(
      status: status ?? this.status,
      articles: this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    articles,
    errorMessage,
  ];
}