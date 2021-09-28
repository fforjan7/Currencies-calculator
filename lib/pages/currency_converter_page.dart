import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/history_bloc.dart';
import 'package:rma_projekt/bloc/searchbar_bloc.dart';
import 'package:rma_projekt/pages/history_page.dart';

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
    return BlocConsumer<CurrencyrateBloc, CurrencyrateState>(
      listener: (context, state) {
        if (state is CurrencyrateError) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error!"),
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<CurrencyrateBloc>(context)
                        .add(InitialFetch());
                    Navigator.of(context).pop();
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CurrencyrateLoaded) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              title: Text("Currency Converter"),
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<HistoryBloc>(context).add(LoadData());
                  Navigator.of(context).pushNamed(HistoryPage.routeName);
                },
                icon: Icon(
                  Icons.history,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CurrencyrateBloc>(context).add(SaveData(
                        DateTime.now().toString(),
                        state.currency1,
                        state.currency2,
                        state.currency3));
                  },
                  icon: Icon(Icons.save),
                ),
              ],
              backgroundColor: Colors.black,
            ),
            body: Column(
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
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
