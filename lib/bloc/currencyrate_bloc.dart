import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rma_projekt/data/currency_api.dart';
import 'package:rma_projekt/data/model/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'currencyrate_event.dart';
part 'currencyrate_state.dart';

class CurrencyrateBloc extends Bloc<CurrencyrateEvent, CurrencyrateState> {
  final CurrencyApi _currencyApi;

  CurrencyrateBloc(this._currencyApi) : super(CurrencyrateInitial());

  @override
  Stream<CurrencyrateState> mapEventToState(
    CurrencyrateEvent event,
  ) async* {
    if (event is GetKeyboardInput) {
      yield* _mapGetKeyboardInputToState(event, state);
    }
    if (event is GetNewCurrency) {
      yield* _mapGetNewCurrencyToState(event, state);
    }
    if (event is InitialFetch) {
      yield* _mapInitialFetchToState(event, state);
    }
    if (event is SaveData) {
      yield* _mapSavedDataToState(event, state);
    }
  }

  Stream<CurrencyrateState> _mapInitialFetchToState(
      InitialFetch event, CurrencyrateState prevState) async* {
    yield CurrencyrateLoading();

    try {
      final currenciesStrings = await _currencyApi.getCurrencies();

      yield CurrencyrateLoaded(
        Currency(currencyName: "EUR", currencyRate: 1, currentValue: "1"),
        Currency(
            currencyName: "HRK",
            currencyRate: currenciesStrings["HRK"],
            currentValue: (1 * currenciesStrings["HRK"]).toStringAsFixed(2)),
        Currency(
            currencyName: "USD",
            currencyRate: currenciesStrings["USD"],
            currentValue: (1 * currenciesStrings["USD"]).toStringAsFixed(2)),
        currenciesStrings,
      );
    } catch (e) {
      yield CurrencyrateError(
          "No internet connection, please try again later!");
    }
  }

  Stream<CurrencyrateState> _mapGetKeyboardInputToState(
      GetKeyboardInput event, CurrencyrateState prevState) async* {
    if (prevState is CurrencyrateLoaded) {
      try {
        Currency currency1 = prevState.currency1;
        Currency currency2 = prevState.currency2;
        Currency currency3 = prevState.currency3;

        if (event.keyboardInput == 'AC') {
          currency1.currentValue = "0";
          currency2.currentValue = "0";
          currency3.currentValue = "0";
        } else if (event.keyboardInput == '⌫') {
          currency1.currentValue = currency1.currentValue
              .substring(0, currency1.currentValue.length - 1);
          if (currency1.currentValue == '') {
            currency1.currentValue = '0';
          }
          currency2 =
              await _currencyApi.calculateCurrencies(currency1, currency2);
          currency3 =
              await _currencyApi.calculateCurrencies(currency1, currency3);
        } else {
          if (currency1.currentValue == '0') {
            currency1.currentValue = event.keyboardInput;
            currency2 =
                await _currencyApi.calculateCurrencies(currency1, currency2);
            currency3 =
                await _currencyApi.calculateCurrencies(currency1, currency3);
          } else {
            if (currency1.currentValue.length < 8) {
              currency1.currentValue =
                  currency1.currentValue + event.keyboardInput;
            }
            currency2 =
                await _currencyApi.calculateCurrencies(currency1, currency2);
            currency3 =
                await _currencyApi.calculateCurrencies(currency1, currency3);
          }
        }
        yield CurrencyrateLoaded(
            currency1, currency2, currency3, prevState.currencies);
      } on NetworkException {
        yield CurrencyrateError(
            "Couldn't fetch Weather. Is the device online?");
      }
    }
  }

  Stream<CurrencyrateState> _mapGetNewCurrencyToState(
      GetNewCurrency event, CurrencyrateState prevState) async* {
    if (prevState is CurrencyrateLoaded) {
      if (event.index == 1) {
        yield CurrencyrateLoaded(
          prevState.currency1,
          Currency(
              currencyName: event.currency.currencyName,
              currencyRate: event.currency.currencyRate,
              currentValue: event.currency.currentValue),
          prevState.currency3,
          prevState.currencies,
        );
      }
      if (event.index == 2) {
        yield CurrencyrateLoaded(
          prevState.currency1,
          prevState.currency2,
          Currency(
              currencyName: event.currency.currencyName,
              currencyRate: event.currency.currencyRate,
              currentValue: event.currency.currentValue),
          prevState.currencies,
        );
      }
    }
  }

  Stream<CurrencyrateState> _mapSavedDataToState(
      SaveData event, CurrencyrateState prevState) async* {
    final sp = await SharedPreferences.getInstance();
    final savedData = sp.getStringList('savedData') ?? [];
    savedData.add(jsonEncode({
      'date': event.date,
      'currency1Name': event.currency1.currencyName,
      'currency1Value': event.currency1.currentValue,
      'currency2Name': event.currency2.currencyName,
      'currency2Value': event.currency2.currentValue,
      'currency3Name': event.currency3.currencyName,
      'currency3Value': event.currency3.currentValue,
    }));
    sp.setStringList('savedData', savedData);
  }
}
