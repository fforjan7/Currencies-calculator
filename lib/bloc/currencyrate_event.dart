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

class SaveData extends CurrencyrateEvent {
  String date;
  Currency currency1;
  Currency currency2;
  Currency currency3;

  SaveData(this.date, this.currency1, this.currency2, this.currency3);
}
