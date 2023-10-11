import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../services/tooltip/tooltipPosition.dart';


class TooltipProperties {
  // Whether the tooltip is hidden or not
  final bool isHidden;

  // The target element for the tooltip
  final String targetElement;

  // The text to be displayed in the tooltip
  final String tooltipText;

  // The font size of the text
  final double textSize;

  // Padding around the tooltip content
  final double padding;

  // Text color of the tooltip
  final Color textColor;

  // Background color of the tooltip
  final Color backgroundColor;

  // The corner radius of the tooltip
  final double cornerRadius;

  // The width of the tooltip
  final double tooltipWidth;

  // The width of the tooltip's arrow
  final double arrowWidth;

  // The height of the tooltip's arrow
  final double arrowHeight;

  // An optional image for the tooltip
  final Uint8List? image;

  // The position of the tooltip (top, bottom, left, right, auto)
  final TooltipPosition tooltipPosition;

  // Optional height of the tooltip
  final double? tootltipHeight;

  // Optional aspect ratio for the tooltip
  final double? aspectRatio;

  TooltipProperties({
    required this.isHidden,
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
    required this.tooltipPosition,
    this.image,
    this.tootltipHeight = 0,
    this.aspectRatio,
  });
}
