part of 'currencyrate_bloc.dart';

@immutable
abstract class CurrencyrateState {
  const CurrencyrateState();
}

class CurrencyrateInitial extends CurrencyrateState {
  const CurrencyrateInitial();
}

class CurrencyrateLoading extends CurrencyrateState {
  const CurrencyrateLoading();
}

class CurrencyrateLoaded extends CurrencyrateState {
  final Currency currency1;
  final Currency currency2;
  final Currency currency3;
  final Map<String, dynamic> currencies;
  const CurrencyrateLoaded(
    this.currency1,
    this.currency2,
    this.currency3,
    this.currencies,
  );

}

class CurrencyrateError extends CurrencyrateState {
  final String message;
  const CurrencyrateError(this.message);

}
