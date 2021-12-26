import 'package:flutter/material.dart';
import 'package:notes_app/notes_model.dart';

abstract class AddNoteEvent{

}
class AddNoteRequest extends AddNoteEvent{
  final Note noteDate;

  AddNoteRequest({required this.noteDate});
}