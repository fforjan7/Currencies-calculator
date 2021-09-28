import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);
  static const routeName = '/historyPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Saved calculations'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Neki tekst',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
