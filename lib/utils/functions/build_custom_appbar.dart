import 'package:flutter/material.dart';
import 'package:notes_with_php_test/utils/constants.dart';

AppBar buildCustomAppBar({
  List<Widget>? actions,
  Widget? title,
  Widget? leading,
}) {
  return AppBar(
    title: title,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: kSecondaryColor,
    actions: actions,
    leading: leading,
  );
}
