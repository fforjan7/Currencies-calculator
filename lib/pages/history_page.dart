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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            (DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(
                                    state.savedData[index]['date']))
                                .toString()),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: FittedBox(
                                      child: Text(
                                        state.savedData[index]
                                            ['currency1Value'],
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 35),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.savedData[index]['currency1Name'],
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: FittedBox(
                                      child: Text(
                                        state.savedData[index]
                                            ['currency2Value'],
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 35),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.savedData[index]['currency2Name'],
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: FittedBox(
                                      child: Text(
                                        state.savedData[index]
                                            ['currency3Value'],
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 35),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.savedData[index]['currency3Name'],
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
