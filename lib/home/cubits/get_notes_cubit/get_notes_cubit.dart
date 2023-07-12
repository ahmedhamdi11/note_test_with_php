import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/api_services.dart';
import 'package:notes_with_php_test/main.dart';

part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitial());

  ApiServices apiServices = ApiServices();

  getNotes() async {
    emit(GetNotesLoadingState());
    var result = await apiServices.post(
      endPoint: 'notes/get_notes.php',
      data: {
        'user_id': prefs.getInt('user_id').toString(),
      },
    );

    result.fold(
      (l) => emit(GetNotesFailureState(l.errMessage)),
      (jsonData) {
        List<Map<String, dynamic>> notes = [];

        for (int i = 0; i < jsonData['data'].length; i++) {
          notes.add(jsonData['data'][i]);
        }
        emit(GetNotesSuccessState(notes));
      },
    );
  }
}
