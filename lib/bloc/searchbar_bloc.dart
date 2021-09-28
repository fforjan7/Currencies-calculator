import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'searchbar_event.dart';
part 'searchbar_state.dart';

class SearchbarBloc extends Bloc<SearchbarEvent, SearchbarState> {
  SearchbarBloc() : super(SearchbarInitial());

  @override
  Stream<SearchbarState> mapEventToState(SearchbarEvent event) async* {
    if (event is ChangedValue) {
      final List<String> currenciesListOnSearch = event.currenciesList
          .where((element) =>
              element.toLowerCase().contains(event.enteredValue.toLowerCase()))
          .toList();
      yield SearchbarLoaded(currenciesListOnSearch);
    }
  }
}
