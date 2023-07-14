import 'package:flutter/material.dart';
import 'package:notes_with_php_test/main.dart';
import 'package:notes_with_php_test/utils/api_services.dart';
import 'package:notes_with_php_test/utils/functions/show_snack_bar.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_button.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_text_field.dart';
import 'package:notes_with_php_test/utils/constants.dart';
import 'package:notes_with_php_test/utils/functions/check_input_validation.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApiServices apiServices = ApiServices();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  signInUser({required String email, required String password}) async {
    var result = await apiServices.post(
      endPoint: 'auth/sign_in.php',
      data: {
        'email': email,
        'password': password,
      },
    );
    result.fold((l) {
      _onFailure();
    }, (jsonData) {
      _onSuccess(
        id: jsonData['data']['id'],
        email: jsonData['data']['email'],
        userName: jsonData['data']['user_name'],
      );
    });
  }

  _onSuccess({
    required int id,
    required String email,
    required String userName,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      kHomeViewId,
      (route) => false,
    );
    prefs.setInt('user_id', id);
    prefs.setString('user_name', userName);
    prefs.setString('email', email);
  }

  _onFailure() {
    showMySnackBar(
      context,
      backgroundColor: Colors.red,
      content:
          'user note found, please check your email and password and try again!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 80,
            ),
            CustomTextField(
              validator: (value) {
                return checkInputValidation(value!, 10, 60);
              },
              controller: _emailController,
              hint: 'Email here',
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomTextField(
              validator: (value) {
                return checkInputValidation(value!, 8, 40);
              },
              controller: _passwordController,
              hint: 'Password here',
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  signInUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
              buttonText: 'LogIn',
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(kRegisterViewId);
                  },
                  child: const Text(
                    'Register Now',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
