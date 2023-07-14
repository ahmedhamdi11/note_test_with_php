import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/api_services.dart';
import 'package:notes_with_php_test/main.dart';
import 'package:notes_with_php_test/utils/functions/show_snack_bar.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  ApiServices apiServices = ApiServices();

  late String title;
  late String content;
  File? image;

  addNote(BuildContext context) async {
    if (image == null) {
      emit(AddNoteLoadingState());

      var result = await apiServices.post(
        endPoint: 'notes/add_note.php',
        data: {
          'title': title,
          'content': content,
          'user_id': prefs.getInt('user_id').toString(),
          'note_image': '',
        },
      );

      result.fold(
        (l) => emit(AddNoteFailureState(l.errMessage)),
        (r) => emit(AddNoteSuccessState()),
      );
    } else {
      emit(AddNoteLoadingState());

      var result = await apiServices.postRequestWithFile(
        endPoint: 'notes/add_note.php',
        data: {
          'title': title,
          'content': content,
          'user_id': prefs.getInt('user_id').toString(),
          'note_image': '',
        },
        image: image!,
      );

      result.fold(
        (l) => emit(AddNoteFailureState(l.errMessage)),
        (r) => emit(AddNoteSuccessState()),
      );
    }
  }
}
