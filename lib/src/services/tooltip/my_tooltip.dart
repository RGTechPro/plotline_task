import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_border.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';

class MyToolTip extends StatefulWidget {
  const MyToolTip(
      {super.key,
      required this.child,
      this.tooltipPosition = TooltipPosition.right,
      required this.arrowHeight,
      required this.arrowWidth});

  final Widget child;
  final TooltipPosition tooltipPosition;
  final double arrowHeight;
  final double arrowWidth;
  @override
  State<MyToolTip> createState() => _MyToolTipState();
}

class _MyToolTipState extends State<MyToolTip> {
  double leftpos = 0;
  double rightpos = 0;
  double toppos = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    leftpos = offset.dx - 125 + size.width / 2;
    rightpos = leftpos + 250;

    switch (widget.tooltipPosition) {
      case TooltipPosition.top:
        setRelativePositionToTop(offset);
        break;
      case TooltipPosition.left:
        setRelativePositionToLeft(offset);
        break;
      case TooltipPosition.right:
        setRelativePositionToRight(offset, size);
        break;
      case TooltipPosition.bottom:
        setRelativePositionToBottom(offset, size);
      case TooltipPosition.auto:
        setRelativePositionToBottom(offset, size);

        break;
      default:
        setRelativePositionToBottom(offset, size);
    }

    TooltipPosition newTooltipPosition = readjust(offset, size);
    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
            left: leftpos,
            top: toppos,
            child: buildOverlay(tooltipPosition: newTooltipPosition));
      },
    );
    overlay.insert(entry);
  }

  TooltipPosition readjust(Offset offset, Size size) {
    TooltipPosition newTooltipPosition = widget.tooltipPosition;
    //readjustment vertically
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //readjustment of top
    if (toppos < 0) {

      newTooltipPosition = TooltipPosition.bottom;
      setRelativePositionToBottom(offset, size);
    }
    //readjustment of bottom
    if (screenHeight - toppos < 35) {
      newTooltipPosition = TooltipPosition.top;
      setRelativePositionToTop(offset);
    }
    ///////

//readjustment horizontally
    if (rightpos > screenWidth) {
      leftpos = leftpos - (rightpos - screenWidth);
    }
    if (leftpos < 0) {
      leftpos = 0;
    }
    //
    return newTooltipPosition;
  }

  void setRelativePositionToTop(Offset offset) {
    toppos = offset.dy - 35 - widget.arrowHeight;
  }

  void setRelativePositionToLeft(Offset offset) {
    leftpos = offset.dx - 250-widget.arrowHeight;
    rightpos = leftpos + 250+widget.arrowHeight;

    toppos = offset.dy + 5;
  }

  void setRelativePositionToRight(Offset offset, Size size) {
    leftpos = offset.dx + size.width+widget.arrowHeight;
    toppos = offset.dy+5;
  }

  void setRelativePositionToBottom(Offset offset, Size size) {
    toppos = offset.dy + size.height + widget.arrowHeight;
  }

  Widget buildOverlay({required TooltipPosition tooltipPosition}) {
    final renderBox = context.findRenderObject() as RenderBox;
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 35,
        width: 250,
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: TooltipBorder(
              renderBox: renderBox,
              tooltipPosition: tooltipPosition,
              arrowHeight: widget.arrowHeight,
              arrowWidth: widget.arrowWidth),
          shadows: const [
            BoxShadow(
                color: Colors.black, blurRadius: 2.0, offset: Offset(1, 1)),
          ],
        ),
        // alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(4),
        child: const Text(
          'Tooltip text goes here',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white, // Set the text color
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
