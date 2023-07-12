import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/home/cubits/update_note_cubit/update_note_cubit.dart';
import 'package:notes_with_php_test/utils/constants.dart';
import 'package:notes_with_php_test/utils/functions/check_input_validation.dart';
import 'package:notes_with_php_test/utils/functions/show_snack_bar.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_button.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_text_field.dart';

class UpdateNoteBody extends StatefulWidget {
  const UpdateNoteBody({
    super.key,
    required this.note,
  });
  final Map<String, dynamic> note;
  @override
  State<UpdateNoteBody> createState() => _UpdateNoteBodyState();
}

class _UpdateNoteBodyState extends State<UpdateNoteBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _title;
  late TextEditingController _content;

  @override
  void initState() {
    super.initState();

    _title = TextEditingController();
    _content = TextEditingController();

    _title.text = widget.note['note_title'];
    _content.text = widget.note['note_content'];
  }

  @override
  void dispose() {
    super.dispose();

    _title.dispose();
    _content.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UpdateNoteCubit updateNoteCubit = BlocProvider.of<UpdateNoteCubit>(context);

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.only(top: 48),
        children: <Widget>[
          CustomTextField(
            controller: _title,
            validator: (value) {
              return checkInputValidation(value!, 0, 20);
            },
            hint: 'Note Title',
          ),
          const SizedBox(
            height: 12.0,
          ),
          CustomTextField(
            controller: _content,
            validator: (value) {
              return checkInputValidation(value!, 0, 500);
            },
            hint: 'Note Content ...',
            maxLines: 5,
          ),
          const SizedBox(
            height: 22.0,
          ),
          BlocConsumer<UpdateNoteCubit, UpdateNoteStates>(
            listener: (context, state) {
              if (state is UpdateNoteFailureState) {
                showMySnackBar(
                  context,
                  backgroundColor: Colors.red,
                  content: state.errMessage,
                );
              }
              if (state is UpdateNoteSuccessState) {
                showMySnackBar(
                  context,
                  backgroundColor: Colors.green,
                  content: 'Note updated successfully',
                );
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(kHomeViewId, (route) => false);
              }
            },
            builder: (context, state) {
              if (state is UpdateNoteLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      updateNoteCubit.updateNote(
                        title: _title.text,
                        content: _content.text,
                        noteId: widget.note['note_id'],
                      );
                    }
                  },
                  buttonText: 'Update',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
