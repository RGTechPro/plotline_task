import 'package:flutter/material.dart';

import 'my_color_picker.dart';

class ColorPicker extends StatelessWidget {
  final String label;
  final Color initialColor;
  final Function(Color) onSelectColor;

  ColorPicker({
    required this.label,
    required this.initialColor,
    required this.onSelectColor,
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
                fontSize: 16.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyColorPicker(
              onSelectColor: onSelectColor,
              availableColors: const [
                Colors.white,
                Colors.black,
                Colors.blue,
                Colors.green,
                Colors.greenAccent,
                Colors.yellow,
                Colors.orange,
                Colors.red,
                Colors.purple,
                Colors.grey,
              ],
              initialColor: initialColor,
            ),
          ),
        ],
      ),
    );
  }
}
