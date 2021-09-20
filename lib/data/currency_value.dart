import 'package:flutter/material.dart';
import 'package:rma_projekt/data/model/currency.dart';
import 'package:rma_projekt/pages/currencies_list.dart';

class CurrencyValue extends StatefulWidget {
  Map<String, dynamic> currencies;
  Currency currency;
  Color numericColor;
  int index;
  String eurValue;

  CurrencyValue({
    Key? key,
    required this.currency,
    required this.numericColor,
    required this.currencies,
    required this.index,
    required this.eurValue,
  }) : super(key: key);

  @override
  _CurrencyValueState createState() => _CurrencyValueState();
}

class _CurrencyValueState extends State<CurrencyValue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.055,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 20.0),
                child: InkWell(
                  onTap: () {
                    if (widget.index > 0) {
                      Navigator.of(context).pushNamed(
                        CurrenciesListScreen.routeName,
                        arguments: {
                          'currency': widget.currency,
                          'currencies': widget.currencies,
                          'index': widget.index,
                          'eur': widget.eurValue,
                        },
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        widget.currency.currencyName,
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      if (widget.index > 0)
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        )
                      else
                        Container(
                          margin: EdgeInsets.only(right: 20.0),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.height * 0.37,
                child: FittedBox(
                  child: Text(
                    widget.currency.currentValue,
                    style: TextStyle(fontSize: 30, color: widget.numericColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
