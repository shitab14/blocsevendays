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

  const GetNewsEvent(this.q, this.from, this.sortBy,);

  @override
  List<Object> get props => [
    q, from, sortBy
  ];
}

class SelectDateEvent extends MainEvent {
  final DateTime selectedDate;

  const SelectDateEvent(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class ChangeWeekEvent extends MainEvent {
  final int direction;

  const ChangeWeekEvent(this.direction);

  @override
  List<Object> get props => [direction];
}