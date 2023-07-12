import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.controller,
    this.validator,
    this.maxLines,
    this.onChanged,
  });
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(12.0),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        onChanged: onChanged,
        maxLines: maxLines,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[300],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
