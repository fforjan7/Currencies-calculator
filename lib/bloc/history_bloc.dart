import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());
  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is LoadData) {
      final sp = await SharedPreferences.getInstance();
      final savedData = sp.getStringList('savedData') ?? [];
      final savedDataMaps = savedData.map((e) => jsonDecode(e)).toList();
      yield HistoryLoaded(savedDataMaps);
    }
    if (event is DeleteHistory) {
      final sp = await SharedPreferences.getInstance();
      sp.remove('savedData');
      yield HistoryLoaded([]);
    }
  }
}
