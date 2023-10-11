import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltipPosition.dart';


class TooltipBorder extends ShapeBorder {
  TooltipBorder(
      {this.usePadding = false,
      required this.renderBox,
      required this.tooltipPosition,
      required this.arrowWidth,
      required this.arrowHeight});

  final RenderBox renderBox;
  final bool usePadding;
  final TooltipPosition tooltipPosition;
  final double arrowWidth;
  final double arrowHeight;
  Size? size;
  Offset? offset;
  double? startX;
  double? startY;
  double? relativex1;
  double? relativey1;
  double? relativex2;
  double? relativey2;
  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    size = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);
    //for bottom

    switch (tooltipPosition) {
      case TooltipPosition.top:
        setRelativePositionToTop();
        break;
      case TooltipPosition.left:
        setRelativePositionToLeft();
        break;
      case TooltipPosition.right:
        setRelativePositionToRight();
        break;
      case TooltipPosition.bottom:
        setRelativePositionToBottom();
      case TooltipPosition.auto:
        setRelativePositionToBottom();

        break;
      default:
        setRelativePositionToBottom();
    }

    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 0));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)))
      ..moveTo(startX!, startY!)
      ..relativeLineTo(relativex1!, relativey1!)
      ..relativeLineTo(relativex2!, relativey2!)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  void setRelativePositionToTop() {
    startX = offset!.dx + size!.width / 2 - arrowWidth/2;
    startY = offset!.dy-arrowHeight;
    relativex1 = arrowWidth/2;
    relativex2 = arrowWidth/2;
    relativey1 = arrowHeight;
    relativey2 = -arrowHeight;
  }

  void setRelativePositionToBottom() {
    startX = offset!.dx + size!.width / 2-arrowWidth/2;
    startY = size!.height + offset!.dy+arrowHeight;
    relativex1 = arrowWidth/2;
    relativex2 = arrowWidth/2;
    relativey1 = -arrowHeight;
    relativey2 = arrowHeight;
  }

  void setRelativePositionToLeft() {
    startX = offset!.dx-arrowHeight;
    startY = offset!.dy + size!.height / 2 -arrowWidth/2;
    relativex1 = arrowHeight;
    relativex2 = -arrowHeight;
    relativey1 = arrowWidth/2;
    relativey2 = arrowWidth/2;
  }

  void setRelativePositionToRight() {

    startX = offset!.dx+size!.width+arrowHeight;
    startY = offset!.dy + size!.height / 2 -arrowWidth/2;
    relativex1 = -arrowHeight;
    relativex2 = arrowHeight;
    relativey1 = arrowWidth/2;
    relativey2 = arrowWidth/2;

  }
}
