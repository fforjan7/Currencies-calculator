import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/history_bloc.dart';
import 'package:rma_projekt/bloc/searchbar_bloc.dart';
import 'package:rma_projekt/pages/history_page.dart';

import 'bloc/currencyrate_bloc.dart';
import 'data/currency_api.dart';
import 'pages/currencies_list.dart';
import 'pages/currency_converter_page.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CurrencyrateBloc(ApiClient())..add(InitialFetch()),
        ),
        BlocProvider(create: (context) => SearchbarBloc()),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
      ],
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
        HistoryPage.routeName: (ctx) => HistoryPage(),
      },
    );
  }
}
