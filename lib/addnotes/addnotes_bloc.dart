import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/addnotes/addnotes_event.dart';
import 'package:notes_app/addnotes/addnotes_state.dart';
import 'package:notes_app/database/notes_database.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, NoteState> {
  final _notesDatabase = NotesDatabase.instance;

  AddNoteBloc() : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(AddNoteEvent event) async* {
    if (event is AddNoteRequest) {
      yield NoteAddClick();
      try {
        final notesResponce = await _notesDatabase.create(event.noteDate);
        yield NoteAddSuccess(responce:notesResponce);
      } catch (e) {
        yield NoteAddFailed(error: e);
      }
    }
  }
}