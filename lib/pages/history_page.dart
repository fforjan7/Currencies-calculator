import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/history_bloc.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<HistoryBloc>(context).add(DeleteHistory());
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) => Row(
                children: [
                  Text(
                    (DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(state.savedData[index]['date']))
                        .toString()),
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    state.savedData[index]['currency1Name'],
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    state.savedData[index]['currency1Value'],
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => Divider(
                color: Colors.white,
              ),
              itemCount: state.savedData.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
