import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/api_services.dart';

part 'update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteStates> {
  UpdateNoteCubit() : super(UpdateNoteInitial());
  ApiServices apiServices = ApiServices();

  updateNote({
    required String title,
    required String content,
    required int noteId,
  }) async {
    emit(UpdateNoteLoadingState());
    var result = await apiServices.post(
      endPoint: 'notes/update_note.php',
      data: {
        'note_title': title,
        'note_content': content,
        'note_id': '$noteId',
      },
    );

    result.fold(
      (l) => emit(UpdateNoteFailureState(l.errMessage)),
      (r) => emit(UpdateNoteSuccessState()),
    );
  }
}
