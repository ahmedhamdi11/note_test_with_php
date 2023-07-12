import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/api_services.dart';
import 'package:notes_with_php_test/main.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  ApiServices apiServices = ApiServices();

  late String title;
  late String content;

  addNote() async {
    emit(AddNoteLoadingState());
    var result = await apiServices.post(
      endPoint: 'notes/add_note.php',
      data: {
        'title': title,
        'content': content,
        'user_id': prefs.getInt('user_id').toString(),
      },
    );

    result.fold(
      (l) => emit(AddNoteFailureState(l.errMessage)),
      (r) => emit(AddNoteSuccessState()),
    );
  }
}
