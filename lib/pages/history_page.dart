import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/history_bloc.dart';

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
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) => Row(
                children: [
                  Text(
                    DateTime.parse(state.savedData[index]['date']).toString(),
                    style: TextStyle(color: Colors.blue),
                  )
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
