import 'package:flutter_bloc/flutter_bloc.dart';
import '../notes_model.dart';

abstract class NoteState{}

class NoteInitial extends NoteState{}

class NoteAddClick extends NoteState{}

class NoteAddSuccess extends NoteState{
  final responce;
  NoteAddSuccess({required this.responce});
}

class NoteAddFailed extends NoteState{
  final error;
  NoteAddFailed({required this.error});
}