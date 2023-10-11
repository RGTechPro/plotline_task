import 'package:flutter/material.dart';
import 'package:plotline_task/src/constants.dart';

class FormFieldWithLabel extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final TextEditingController controller;
  final void Function()? onTap;

  const FormFieldWithLabel({super.key, 
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: kFormLabelTextStyle
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: kFromInputDecoration,
            value: value,
            items: items.map((element) {
              return DropdownMenuItem<String>(
                value: element,
                child: Text(element),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
