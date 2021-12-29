abstract class DeleteNoteState {}

class DeleteNoteInitial extends DeleteNoteState {}

class DeleteNoteClick extends DeleteNoteState {}

class DeleteNoteSuccess extends DeleteNoteState {}

class DeleteNoteError extends DeleteNoteState {
  final error;
  DeleteNoteError({required this.error});
}
