import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/updatenote/update_event.dart';
import 'package:notes_app/updatenote/update_state.dart';

class UpdateNoteBloc extends Bloc<UpdateNoteEvent,UpdateNoteState>{
  final _noteDatabase=NotesDatabase.instance;

  UpdateNoteBloc():super(UpdateNoteInitial());

  @override
  Stream<UpdateNoteState> mapEventToState(UpdateNoteEvent event)async*{
    if(event is UpdateNoteRequest){
      yield UpdateNoteClick();
      try{
        _noteDatabase.update(event.noteDate);
        print("Updated");
        yield UpdateNoteSuccess();
      }
      catch (e){
        yield UpdateNoteError(error: e);
      }
    }
  }
}