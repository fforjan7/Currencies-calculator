part of 'searchbar_bloc.dart';

@immutable
abstract class SearchbarState {}

class SearchbarInitial extends SearchbarState {}

class SearchbarLoaded extends SearchbarState {
  final List<String> sortedCurrenciesList;

  SearchbarLoaded(this.sortedCurrenciesList);
}
