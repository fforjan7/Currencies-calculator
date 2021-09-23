import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currencyrate_bloc.dart';

class NumericKeyboard extends StatelessWidget {
  const NumericKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Table(children: [
            TableRow(
              children: [
                buildNumericButton(context, '7'),
                buildNumericButton(context, '8'),
                buildNumericButton(context, '9'),
              ],
            ),
            TableRow(
              children: [
                buildNumericButton(context, '4'),
                buildNumericButton(context, '5'),
                buildNumericButton(context, '6'),
              ],
            ),
            TableRow(
              children: [
                buildNumericButton(context, '1'),
                buildNumericButton(context, '2'),
                buildNumericButton(context, '3'),
              ],
            ),
            TableRow(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Theme.of(context).primaryColor,
                ),
                buildNumericButton(context, '0'),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Table(
            children: [
              TableRow(
                children: [
                  buildOperationButton(context, 'AC'),
                ],
              ),
              TableRow(
                children: [
                  buildOperationButton(context, '⌫'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildNumericButton(BuildContext context, String text) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: Theme.of(context).primaryColor,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.blue),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(14.0),
          ),
          shape: MaterialStateProperty.all(
            const CircleBorder(),
          ),
        ),
        onPressed: () => {
          //buttonPressed(text, context, selectedVariable),
          buttonPressed(context, text)
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 35,
          ),
        ),
      ),
    );
  }

  SizedBox buildOperationButton(BuildContext context, String text) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 0.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 2.0,
        ),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(5.0),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                  side: BorderSide(
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  )),
            ),
          ),
          onPressed: () {
            buttonPressed(context, text);
          },
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor!,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  void buttonPressed(BuildContext context, String keyPressed) {
    final currencyrateBloc = context.read<CurrencyrateBloc>();
    currencyrateBloc.add(GetKeyboardInput(keyPressed));
  }
}
