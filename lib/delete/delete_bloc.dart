import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/delete/delete_event.dart';
import 'package:notes_app/delete/delete_state.dart';

class DeleteNoteBloc extends Bloc<DeleteNoteEvent,DeleteNoteState>{
  final _noteDatabase=NotesDatabase.instance;

  DeleteNoteBloc():super(DeleteNoteInitial());

  @override
  Stream<DeleteNoteState> mapEventToState(DeleteNoteEvent event)async*{
    if(event is DeleteNoteRequest){
      yield DeleteNoteClick();
      try{
        _noteDatabase.delete(event.id);
        print("deleted");
        yield DeleteNoteSuccess();
      }
      catch (e){
        yield DeleteNoteError(error: e);
      }
    }
  }
}