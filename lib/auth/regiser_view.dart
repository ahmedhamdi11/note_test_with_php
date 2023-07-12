import 'package:flutter/material.dart';
import 'package:notes_with_php_test/utils/api_services.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_button.dart';
import 'package:notes_with_php_test/utils/shared_componants/custom_text_field.dart';
import 'package:notes_with_php_test/utils/constants.dart';
import 'package:notes_with_php_test/utils/functions/check_input_validation.dart';
import 'package:notes_with_php_test/utils/functions/show_snack_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApiServices apiServices = ApiServices();

  registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    if (formKey.currentState!.validate()) {
      var result = await apiServices.post(
        endPoint: 'auth/sign_up.php',
        data: {
          "user_name": userName,
          "email": email,
          "password": password,
        },
      );

      result.fold((l) => _onFailure(l.errMessage), (r) => _onSuccess());
    }
  }

  void _onFailure(String errMessage) {
    showMySnackBar(
      context,
      backgroundColor: Colors.red,
      content: errMessage,
    );
  }

  _onSuccess() {
    Navigator.of(context).pushNamed(kLoginViewId);
    showMySnackBar(
      context,
      backgroundColor: Colors.green,
      content: 'Register done successfully you can login now',
    );
  }

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 80,
            ),
            CustomTextField(
              validator: (value) {
                return checkInputValidation(value!, 3, 60);
              },
              controller: userNameController,
              hint: 'User Name',
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomTextField(
              validator: (value) {
                return checkInputValidation(value!, 10, 60);
              },
              controller: emailController,
              hint: 'Email ',
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomTextField(
              validator: (value) {
                return checkInputValidation(value!, 8, 40);
              },
              controller: passwordController,
              hint: 'Password ',
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomButton(
              onPressed: () {
                registerUser(
                  userName: userNameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              buttonText: 'Register',
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
