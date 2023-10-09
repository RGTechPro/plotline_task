import 'package:flutter/material.dart';

import '../constants.dart';

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback onTap;

  ImagePickerWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Select image',
              style:
                  kFormLabelTextStyle, // You should define kFormLabelTextStyle
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 45,
              width: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffD9D9D9)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image),
            ),
          ),
        ],
      ),
    );
  }
}
