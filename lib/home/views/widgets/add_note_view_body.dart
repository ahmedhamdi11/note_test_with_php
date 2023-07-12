import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/utils/constants.dart';
import 'package:notes_with_php_test/utils/functions/check_input_validation.dart';
import 'package:notes_with_php_test/utils/functions/show_snack_bar.dart';
import 'package:notes_with_php_test/home/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_button.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_text_field.dart';

class AddNoteViewBody extends StatefulWidget {
  const AddNoteViewBody({
    super.key,
  });

  @override
  State<AddNoteViewBody> createState() => _AddNoteViewBodyState();
}

class _AddNoteViewBodyState extends State<AddNoteViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AddNoteCubit addNoteCubit = BlocProvider.of<AddNoteCubit>(context);

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.only(top: 48),
        children: <Widget>[
          CustomTextField(
            onChanged: (value) {
              addNoteCubit.title = value;
            },
            validator: (value) {
              return checkInputValidation(value!, 0, 20);
            },
            hint: 'Note Title',
          ),
          const SizedBox(
            height: 12.0,
          ),
          CustomTextField(
            onChanged: (value) {
              addNoteCubit.content = value;
            },
            validator: (value) {
              return checkInputValidation(value!, 0, 500);
            },
            hint: 'Note Content ...',
            maxLines: 5,
          ),
          const SizedBox(
            height: 22.0,
          ),
          BlocConsumer<AddNoteCubit, AddNoteState>(
            listener: (context, state) {
              if (state is AddNoteFailureState) {
                showMySnackBar(
                  context,
                  backgroundColor: Colors.red,
                  content: state.errMessage,
                );
              }
              if (state is AddNoteSuccessState) {
                //BlocProvider.of<GetNotesCubit>(context).getNotes();
                showMySnackBar(
                  context,
                  backgroundColor: Colors.green,
                  content: 'Note added successfully',
                );
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(kHomeViewId, (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AddNoteLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addNoteCubit.addNote();
                    }
                  },
                  buttonText: 'Add Note',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
