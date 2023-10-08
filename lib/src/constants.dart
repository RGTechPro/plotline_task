import 'package:flutter/material.dart';

const kFormLabelTextStyle = TextStyle(fontSize: 13.5, color: Colors.black);
var kFromInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0), // Rounded border
    borderSide: const BorderSide(color: Color(0xffD9D9D9)), // Border color
  ), // Background color
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0), // Rounded border
    borderSide: const BorderSide(color: Color(0xffD9D9D9)), // Border color
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide:
        const BorderSide(color: Color(0xffD9D9D9)), // Border color when focused
  ),
  hintText: 'Enter input', // Placeholder text
  hintStyle: const TextStyle(color: Colors.grey), // Placeholder text color
);
