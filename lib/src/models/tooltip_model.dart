import 'package:flutter/material.dart';

class TooltipProperties {
  final String targetElement;
  final String tooltipText;
  final double textSize;
  final double padding;
  final Color textColor;
  final Color backgroundColor;
  final double cornerRadius;
  final double tooltipWidth;
  final double arrowWidth;
  final double arrowHeight;
  final String? image;
  TooltipProperties({
    required this.targetElement,
    required this.tooltipText,
    required this.textSize,
    required this.padding,
    required this.textColor,
    required this.backgroundColor,
    required this.cornerRadius,
    required this.tooltipWidth,
    required this.arrowWidth,
    required this.arrowHeight,
     this.image
  });
}
