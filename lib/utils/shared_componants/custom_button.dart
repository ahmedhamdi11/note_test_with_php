import 'package:flutter/material.dart';
import 'package:notes_with_php_test/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.color = kPrimaryColor,
  });
  final void Function()? onPressed;
  final String buttonText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: MaterialButton(
          onPressed: onPressed,
          height: 50,
          color: color,
          child: Text(buttonText),
        ),
      ),
    );
  }
}
