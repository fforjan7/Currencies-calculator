import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/pages/currencies_list.dart';

import 'bloc/currencyrate_bloc.dart';
import 'data/currency_api.dart';
import 'data/model/currency.dart';
import 'pages/currency_converter_page.dart';

void main() => runApp(BlocProvider(
      create: (context) => CurrencyrateBloc(ApiClient())..add(InitialFetch()),
      child: MyApp(),
    ));

    

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CurrVerter',
      home: CurrencyConverterPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue,
        ),
      ),
      routes: {
        CurrenciesListScreen.routeName: (ctx) => CurrenciesListScreen(),
      },
    );
  }
}
