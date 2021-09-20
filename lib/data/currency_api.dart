import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/currency.dart';

abstract class CurrencyApi {
  Future<Currency> calculateCurrencies(Currency currency1, Currency currency2);
  Future<Map<String,dynamic>> getCurrencies();
}

class ApiClient implements CurrencyApi {
  final Uri currencyURL = Uri.http("data.fixer.io", "/api/latest",
      {"access_key": "16b7f25955e6263440ea8ea6acda4f72"});


  //List<String> currencies = (list.keys).toList();
  @override
  Future<Map<String,dynamic>> getCurrencies() async {
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["rates"];
      return list;
    } else {
      throw Exception("Connection Failed");
    }
  }

  @override
  Future<Currency> calculateCurrencies(Currency currency1, Currency currency2) {
    return Future(
      () {
        double newValue;
        newValue = double.parse(currency1.currentValue);
        newValue *= currency2.currencyRate;
        currency2.currentValue = newValue.toStringAsFixed(2);

        return currency2;
      },
    );
  }
}

class NetworkException implements Exception {}
