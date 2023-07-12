import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_php_test/auth/login_view.dart';
import 'package:notes_with_php_test/auth/regiser_view.dart';
import 'package:notes_with_php_test/home/cubits/delete_note/add_note_cubit.dart';
import 'package:notes_with_php_test/utils/constants.dart';
import 'package:notes_with_php_test/home/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_with_php_test/home/views/add_note_view.dart';
import 'package:notes_with_php_test/home/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/cubits/get_notes_cubit/get_notes_cubit.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test php api with flutter',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
        scaffoldBackgroundColor: kSecondaryColor,
      ),
      initialRoute:
          prefs.getInt('user_id') == null ? kLoginViewId : kHomeViewId,
      routes: {
        kLoginViewId: (context) => const LoginView(),
        kRegisterViewId: (context) => const RegisterView(),
        kHomeViewId: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GetNotesCubit()..getNotes(),
                ),
                BlocProvider(
                  create: (context) => DeleteNoteCubit(),
                ),
              ],
              child: const HomeView(),
            ),
        kAddNoteViewId: (context) => BlocProvider(
              create: (context) => AddNoteCubit(),
              child: const AddNoteView(),
            ),
      },
    );
  }
}
