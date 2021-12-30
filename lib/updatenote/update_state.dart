abstract class UpdateNoteState {}

class UpdateNoteInitial extends UpdateNoteState {}

class UpdateNoteClick extends UpdateNoteState {}

class UpdateNoteSuccess extends UpdateNoteState {}

class UpdateNoteError extends UpdateNoteState {
  final error;
  UpdateNoteError({required this.error});
}
