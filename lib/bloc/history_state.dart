part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<dynamic> savedData;

  HistoryLoaded(this.savedData);
}
