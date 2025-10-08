part of 'bloc_main.dart';

enum MainStatus { initial, loading, success, failure }

class MainState extends Equatable {
  final MainStatus status;
  final List<ArticleEntity> articles;
  final String? errorMessage;
  final String? selectedDate;
  final DateTime currentWeekStart;

  const MainState({
    this.status = MainStatus.initial,
    this.articles = const [],
    this.errorMessage,
    this.selectedDate,
    required this.currentWeekStart,
  });

  MainState copyWith({
    MainStatus? status,
    List<ArticleEntity>? articles,
    String? errorMessage,
    String? selectedDate,
    DateTime? currentWeekStart,
  }) {
    // AppLogger.debug("SHITAB: state_main: ${articles?.length}");

    return MainState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDate: selectedDate ?? this.selectedDate,
      currentWeekStart: currentWeekStart ?? this.currentWeekStart,
    );
  }

  @override
  List<Object?> get props => [
    status,
    articles,
    errorMessage,
    selectedDate,
    currentWeekStart,
  ];
}