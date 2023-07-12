import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/home/cubits/update_note_cubit/update_note_cubit.dart';
import 'package:notes_with_php_test/home/views/widgets/update_note_body.dart';
import 'package:notes_with_php_test/utils/functions/build_custom_appbar.dart';

class UpdateNoteView extends StatelessWidget {
  const UpdateNoteView({super.key, required this.note});
  final Map<String, dynamic> note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateNoteCubit(),
      child: Scaffold(
        appBar: buildCustomAppBar(
          title: const Text('Update Note'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: UpdateNoteBody(
          note: note,
        ),
      ),
    );
  }
}
