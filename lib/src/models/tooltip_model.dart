import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';

class TooltipProperties {
  final bool isHidden;
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
  final Uint8List? image;
  final TooltipPosition tooltipPosition;
  final double? tootltipHeight;
  final double aspectRatio;
  TooltipProperties(
      {required this.isHidden,
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
      this.tootltipHeight,
      required this.aspectRatio});
}
