import 'package:notes_app/notes_model.dart';

abstract class UpdateNoteEvent{}

class UpdateNoteRequest extends UpdateNoteEvent{
  final Note noteDate;
  UpdateNoteRequest({required this.noteDate});
}