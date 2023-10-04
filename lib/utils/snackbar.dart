import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/resources/socket_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
