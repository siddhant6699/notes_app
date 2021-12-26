import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/homescreen/homescreen_event.dart';
import 'package:notes_app/homescreen/homescreen_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _notesDatabase = NotesDatabase.instance;

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeDatabaseRequest) {
      yield HomeLoadInProgress();

      try {
        final notesResponce = await _notesDatabase.readAllNotes();
        yield HomeLoadSuccess(notesListing: notesResponce);
      } catch (e) {
        yield HomeLoadFailed(error: e);
      }
    }
  }
}
