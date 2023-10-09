import 'package:flutter/material.dart';

class FormFieldWithLabel extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final TextEditingController controller;
  final void Function()? onTap;

  FormFieldWithLabel({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: TextStyle(
                // You can replace this with your kFormLabelTextStyle
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // Replace this with your kFromInputDecoration
              hintText: 'Select an option',
            ),
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
