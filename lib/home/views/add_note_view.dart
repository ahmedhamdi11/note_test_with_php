import 'package:flutter/material.dart';
import 'package:notes_with_php_test/home/views/widgets/add_note_view_body.dart';
import 'package:notes_with_php_test/utils/functions/build_custom_appbar.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: const Text('Add Note'),
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
      body: const AddNoteViewBody(),
    );
  }
}
