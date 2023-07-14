import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/api_services.dart';

part 'add_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteInitial());
  ApiServices apiServices = ApiServices();

  deleteNote({required int noteId, required String noteImage}) async {
    emit(DeleteNoteLoadingState());
    var result = await apiServices.post(
      endPoint: 'notes/delete_note.php',
      data: {
        'note_id': '$noteId',
        'image_name': noteImage,
      },
    );

    result.fold(
      (l) => emit(DeleteNoteFailureState(l.errMessage)),
      (r) => emit(DeleteNoteSuccessState()),
    );
  }
}
