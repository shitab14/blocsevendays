part of 'bloc_main.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class GetNewsEvent extends MainEvent {
  final String q;
  final String from;
  final String sortBy;

  const GetNewsEvent({
    this.q = "tesla",
    this.from = "2025-09-08",
    this.sortBy = "publishedAt",
  });

  @override
  List<Object> get props => [
    q, from, sortBy
  ];
}