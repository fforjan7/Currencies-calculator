part of 'searchbar_bloc.dart';

@immutable
abstract class SearchbarEvent {
  const SearchbarEvent();
}

class ChangedValue extends SearchbarEvent {
  final String enteredValue;
  final List<String> currenciesList;

  const ChangedValue(this.enteredValue, this.currenciesList);
}

