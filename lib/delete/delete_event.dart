import 'package:flutter/material.dart';
import 'package:notes_app/notes_model.dart';

abstract class DeleteNoteEvent{

}
class DeleteNoteRequest extends DeleteNoteEvent{
  final int id;

  DeleteNoteRequest({required this.id});
}