import 'package:flutter/material.dart';
import 'package:plotline_task/src/constants.dart';

class TextFormWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
 final TextInputType textInputType;
 const TextFormWithLabel({
    required this.label,
    required this.controller,
    this.validator,
    super.key,
    this.textInputType=TextInputType.number
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: kFormLabelTextStyle
          ),
        ),
        TextFormField(
          keyboardType: textInputType,
          controller: controller,
          decoration: kFromInputDecoration,
          validator: validator,
        )
      ],
    );
  }
}
