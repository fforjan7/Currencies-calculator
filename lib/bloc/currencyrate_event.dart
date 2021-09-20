part of 'currencyrate_bloc.dart';

@immutable
abstract class CurrencyrateEvent {}

class GetKeyboardInput extends CurrencyrateEvent {
  final String keyboardInput;

  GetKeyboardInput(this.keyboardInput);
}

class GetNewCurrency extends CurrencyrateEvent {
  final Currency currency;
  final int index;
  GetNewCurrency(this.currency, this.index);
}

class InitialFetch extends CurrencyrateEvent {
  InitialFetch();
}
