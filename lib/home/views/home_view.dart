import 'package:flutter/material.dart';
import 'package:notes_with_php_test/utils/constants.dart';
import 'package:notes_with_php_test/utils/functions/build_custom_appbar.dart';
import 'package:notes_with_php_test/home/views/widgets/home_view_body.dart';
import 'package:notes_with_php_test/main.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  _signOut(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
      kLoginViewId,
      (route) => false,
    );
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: const Text('My Notes'),
        actions: [
          const SizedBox(
            width: 22.0,
          ),
          IconButton(
            onPressed: () {
              _signOut(context);
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(kAddNoteViewId);
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}
