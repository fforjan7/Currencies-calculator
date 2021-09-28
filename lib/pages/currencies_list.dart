import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/currencyrate_bloc.dart';
import 'package:rma_projekt/bloc/searchbar_bloc.dart';
import 'package:rma_projekt/data/model/currency.dart';

class CurrenciesListScreen extends StatefulWidget {
  static const routeName = '/currenciesList';

  @override
  State<CurrenciesListScreen> createState() => _CurrenciesListScreenState();
}

class _CurrenciesListScreenState extends State<CurrenciesListScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    final Map<String, dynamic> currenciesMap = routeArgs['currencies'];
    final List<String> entries = currenciesMap.keys.toList();
    final double eurValue = double.parse(routeArgs["eur"]);
    var currentFocus = FocusScope.of(context);

    TextEditingController _editingController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text("List of currencies"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  BlocProvider.of<SearchbarBloc>(context).add(
                    ChangedValue(value, entries),
                  );
                },
                controller: _editingController,
                style: TextStyle(color: Colors.blue),
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  labelStyle: TextStyle(color: Colors.blue),
                  hintStyle: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchbarBloc, SearchbarState>(
                builder: (context, state) {
                  if (state is SearchbarLoaded) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: _editingController.text.isNotEmpty
                          ? state.sortedCurrenciesList.length
                          : entries.length,
                      padding: EdgeInsets.all(mediaQuery.size.height * 0.02),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<CurrencyrateBloc>(context).add(
                              _editingController.text.isNotEmpty
                                  ? GetNewCurrency(
                                      Currency(
                                        currencyName:
                                            state.sortedCurrenciesList[index],
                                        currencyRate: currenciesMap[
                                            state.sortedCurrenciesList[index]],
                                        currentValue: (currenciesMap[
                                                    state.sortedCurrenciesList[
                                                        index]] *
                                                eurValue)
                                            .toStringAsFixed(2),
                                      ),
                                      routeArgs['index'],
                                    )
                                  : GetNewCurrency(
                                      Currency(
                                        currencyName: entries[index],
                                        currencyRate:
                                            currenciesMap[entries[index]],
                                        currentValue:
                                            (currenciesMap[entries[index]] *
                                                    eurValue)
                                                .toStringAsFixed(2),
                                      ),
                                      routeArgs['index'],
                                    ),
                            );
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              currentFocus.focusedChild?.unfocus();
                            }
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                                child: Text(
                              _editingController.text.isNotEmpty
                                  ? state.sortedCurrenciesList[index]
                                  : entries[index],
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            )),
                          ),
                        );
                      },
                    );
                  } else
                    return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
