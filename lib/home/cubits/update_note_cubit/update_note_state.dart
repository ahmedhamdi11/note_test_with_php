part of 'update_note_cubit.dart';

abstract class UpdateNoteStates {}

class UpdateNoteInitial extends UpdateNoteStates {}

class UpdateNoteLoadingState extends UpdateNoteStates {}

class UpdateNoteSuccessState extends UpdateNoteStates {}

class UpdateNoteFailureState extends UpdateNoteStates {
  final String errMessage;

  UpdateNoteFailureState(this.errMessage);
}
