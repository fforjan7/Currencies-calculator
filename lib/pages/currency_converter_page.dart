import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currencyrate_bloc.dart';
import '../data/currency_value.dart';
import '../data/keyboard.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Currency Converter"),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<CurrencyrateBloc, CurrencyrateState>(
        builder: (context, state) {
          if (state is CurrencyrateLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CurrencyValue(
                  index: 0,
                  currencies: state.currencies,
                  currency: state.currency1,
                  numericColor: Colors.red,
                  eurValue: state.currency1.currentValue,
                ),
                CurrencyValue(
                  index: 1,
                  currencies: state.currencies,
                  currency: state.currency2,
                  numericColor: Colors.white,
                  eurValue: state.currency1.currentValue,
                ),
                CurrencyValue(
                  index: 2,
                  currencies: state.currencies,
                  currency: state.currency3,
                  numericColor: Colors.white,
                  eurValue: state.currency1.currentValue,
                ),
                NumericKeyboard(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
