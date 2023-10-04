// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
            readOnly: isReadOnly,
            controller: controller,
            decoration: InputDecoration(
              fillColor: bgColor,
              filled: true,
              hintText: hintText,
            )));
  }
}
