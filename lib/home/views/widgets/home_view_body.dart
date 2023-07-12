import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/home/cubits/get_notes_cubit/get_notes_cubit.dart';

import 'notes_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotesCubit, GetNotesState>(
      builder: (context, state) {
        if (state is GetNotesSuccessState) {
          return state.notes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 120,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'You don\'t have any notes yet, start adding some now!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 68.0,
                    top: 12.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) => NoteItem(
                    note: state.notes[index],
                  ),
                );
        } else if (state is GetNotesFailureState) {
          return Center(
            child: Text(state.errMessage),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
