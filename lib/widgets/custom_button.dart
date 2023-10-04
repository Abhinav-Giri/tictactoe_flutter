import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;

  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 127, 144, 226),
          blurRadius: .5,
          spreadRadius: .5,
        )
      ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: onTap,
            child: Text(text, style: TextStyle(fontSize: 22)),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(
              width,
              50,
            ))),
      ),
    );
  }
}
