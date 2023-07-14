import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_with_php_test/home/cubits/delete_note/add_note_cubit.dart';
import 'package:notes_with_php_test/home/cubits/get_notes_cubit/get_notes_cubit.dart';
import 'package:notes_with_php_test/home/views/update_note_view.dart';
import 'package:notes_with_php_test/utils/api_services.dart';
import 'package:notes_with_php_test/utils/constants.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
  });

  final Map<String, dynamic> note;
  @override
  Widget build(BuildContext context) {
    GetNotesCubit getNotesCubit = BlocProvider.of<GetNotesCubit>(context);
    DeleteNoteCubit deleteNoteCubit = BlocProvider.of<DeleteNoteCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Slidable(
        key: ValueKey(note['note_id']),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          dismissible: DismissiblePane(
            onDismissed: () async {
              await deleteNoteCubit.deleteNote(
                noteId: note['note_id'],
                noteImage: note['note_image'],
              );
              getNotesCubit.getNotes();
            },
          ),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12.0),
              onPressed: (BuildContext context) async {
                await deleteNoteCubit.deleteNote(
                  noteId: note['note_id'],
                  noteImage: note['note_image'],
                );
                getNotesCubit.getNotes();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdateNoteView(note: note),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.zero,
            color: kNoteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageUrl:
                          '${ApiServices().baseImagesUrl}${note['note_image']}',
                      height: 75,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(note['note_title']),
                      subtitle: Text(
                        note['note_content'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
