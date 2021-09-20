import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/currencyrate_bloc.dart';
import 'package:rma_projekt/data/model/currency.dart';

class CurrenciesListScreen extends StatelessWidget {
  static const routeName = '/currenciesList';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    final Map<String, dynamic> currenciesMap = routeArgs['currencies'];
    final List<String> entries = currenciesMap.keys.toList();
    final double eurValue = double.parse(routeArgs["eur"]);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("List of currencies"),
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        itemCount: entries.length,
        padding: EdgeInsets.all(mediaQuery.size.height * 0.02),
        separatorBuilder: (context, index) => Divider(
          color: Colors.white,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              BlocProvider.of<CurrencyrateBloc>(context).add(
                GetNewCurrency(
                  Currency(
                    currencyName: entries[index],
                    currencyRate: currenciesMap[entries[index]],
                    currentValue: (currenciesMap[entries[index]] * eurValue)
                        .toStringAsFixed(2),
                  ),
                  routeArgs['index'],
                ),
              );

              Navigator.of(context).pop();
            },
            child: Container(
              height: 50,
              child: Center(
                  child: Text(
                '${entries[index]}',
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              )),
            ),
          );
        },
      ),
    );
  }
}
