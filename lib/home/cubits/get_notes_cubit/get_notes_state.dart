part of 'get_notes_cubit.dart';

abstract class GetNotesState {}

class GetNotesInitial extends GetNotesState {}

class GetNotesSuccessState extends GetNotesState {
  final List<Map<String, dynamic>> notes;

  GetNotesSuccessState(this.notes);
}

class GetNotesFailureState extends GetNotesState {
  final String errMessage;

  GetNotesFailureState(this.errMessage);
}

class GetNotesLoadingState extends GetNotesState {}
