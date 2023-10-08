import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';

class TooltipBorder extends ShapeBorder {
  const TooltipBorder(
      {this.usePadding = true,
      required this.renderBox,
      required this.tooltipPosition});

  final RenderBox renderBox;
  final bool usePadding;
  final TooltipPosition tooltipPosition;
  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    //for bottom
    var movedx = offset.dx + size.width / 2;
    var movedy = size.height + offset.dy;
    double relative1 = -10;
    double relative2 = 10;
    void setRelativePositionToTop() {
      movedy = offset.dy;
      relative1 = 10;
      relative2 = -10;
    }

    if (tooltipPosition == TooltipPosition.top) {
      setRelativePositionToTop();
    }
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 0));
    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)))
      ..moveTo(movedx, movedy)
      ..relativeLineTo(10, relative1)
      ..relativeLineTo(10, relative2)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
