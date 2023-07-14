import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/api_services.dart';

part 'update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteStates> {
  UpdateNoteCubit() : super(UpdateNoteInitial());
  ApiServices apiServices = ApiServices();
  File? image;

  updateNote({
    required String title,
    required String content,
    required String noteImage,
    required int noteId,
  }) async {
    if (image == null) {
      emit(UpdateNoteLoadingState());
      var result = await apiServices.post(
        endPoint: 'notes/update_note.php',
        data: {
          'note_title': title,
          'note_content': content,
          'note_id': '$noteId',
          'note_image': noteImage,
        },
      );

      result.fold(
        (l) => emit(UpdateNoteFailureState(l.errMessage)),
        (r) => emit(UpdateNoteSuccessState()),
      );
    } else {
      emit(UpdateNoteLoadingState());
      var result = await apiServices.postRequestWithFile(
        endPoint: 'notes/update_note.php',
        data: {
          'note_title': title,
          'note_content': content,
          'note_id': '$noteId',
          'note_image': noteImage,
        },
        image: image!,
      );

      result.fold(
        (l) => emit(UpdateNoteFailureState(l.errMessage)),
        (r) => emit(UpdateNoteSuccessState()),
      );
    }
  }
}
