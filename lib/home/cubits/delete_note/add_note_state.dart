part of 'add_note_cubit.dart';

abstract class DeleteNoteState {}

class DeleteNoteInitial extends DeleteNoteState {}

class DeleteNoteLoadingState extends DeleteNoteState {}

class DeleteNoteSuccessState extends DeleteNoteState {}

class DeleteNoteFailureState extends DeleteNoteState {
  final String errMessage;

  DeleteNoteFailureState(this.errMessage);
}
