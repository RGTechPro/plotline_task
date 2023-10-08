import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.text, required this.onPressed, super.key});

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      ),
    );
  }
}
