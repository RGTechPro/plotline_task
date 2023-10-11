import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plotline_task/src/constants.dart';

class TextFormWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  final List<TextInputFormatter>? inputFormatters;
  const TextFormWithLabel(
      {required this.label,
      required this.controller,
      this.validator,
      super.key,
      this.textInputType = TextInputType.number,
      required this.inputFormatters,
});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: kFormLabelTextStyle),
        ),
        TextFormField(
        
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          controller: controller,
          decoration: kFromInputDecoration,
          validator: validator,
        )
      ],
    );
  }
}
