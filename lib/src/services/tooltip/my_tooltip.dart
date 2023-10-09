import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_border.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';

import '../../models/tooltip_model.dart';

class MyToolTip extends StatefulWidget {
  const MyToolTip({
    super.key,
    required this.child,
   
  
     this.tooltipProperty
    //required this.refresh
  });

  final Widget child;


 final TooltipProperties? tooltipProperty;
  // VoidCallback refresh;
  @override
  State<MyToolTip> createState() => _MyToolTipState();
}

class _MyToolTipState extends State<MyToolTip> {
  double leftpos = 0;
  double rightpos = 0;
  double toppos = 0;
  OverlayEntry? overlayEntry;
  @override
  void dispose() {
    // TODO: implement dispose
    removeOverlay();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
    }
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    leftpos = offset.dx -  widget.tooltipProperty!.tooltipWidth/2 + size.width / 2;
    rightpos = leftpos +  widget.tooltipProperty!.tooltipWidth;

    switch (widget.tooltipProperty!.tooltipPosition) {
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
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
            left: leftpos,
            top: toppos,
            child: buildOverlay(tooltipPosition: newTooltipPosition));
      },
    );
    if(widget.tooltipProperty?.isHidden == false) overlay.insert(overlayEntry!);
  }

  TooltipPosition readjust(Offset offset, Size size) {
    TooltipPosition newTooltipPosition = widget.tooltipProperty!.tooltipPosition;
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

    return newTooltipPosition;
  }

  void setRelativePositionToTop(Offset offset) {
    toppos = offset.dy - 35 - widget.tooltipProperty!.arrowHeight;
  }

  void setRelativePositionToLeft(Offset offset) {
    leftpos = offset.dx - widget.tooltipProperty!.tooltipWidth - widget.tooltipProperty!.arrowHeight;
    rightpos = leftpos +  widget.tooltipProperty!.tooltipWidth + widget.tooltipProperty!.arrowHeight;

    toppos = offset.dy + 5;
  }

  void setRelativePositionToRight(Offset offset, Size size) {
    leftpos = offset.dx + size.width + widget.tooltipProperty!.arrowHeight;
    toppos = offset.dy + 5;
  }

  void setRelativePositionToBottom(Offset offset, Size size) {
    toppos = offset.dy + size.height + widget.tooltipProperty!.arrowHeight;
  }

  void removeOverlay() {
    overlayEntry!.remove();
  }

  Widget buildOverlay({required TooltipPosition tooltipPosition}) {
    final renderBox = context.findRenderObject() as RenderBox;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          overlayEntry!.remove();
        },
        child: Container(
          height: 35,
          width: widget.tooltipProperty!.tooltipWidth,
          decoration: ShapeDecoration(
            color: widget.tooltipProperty!.backgroundColor,
            shape: TooltipBorder(
                renderBox: renderBox,
                tooltipPosition: tooltipPosition,
                arrowHeight: widget.tooltipProperty!.arrowHeight,
                arrowWidth: widget.tooltipProperty!.arrowWidth),
            shadows: const [
              BoxShadow(
                  color: Colors.black, blurRadius: 2.0, offset: Offset(1, 1)),
            ],
          ),
          // alignment: Alignment.centerRight,
          padding:  EdgeInsets.all(widget.tooltipProperty!.padding),
          child:  Text(
           widget.tooltipProperty!.tooltipText,
            style: TextStyle(
              fontSize: widget.tooltipProperty!.textSize,
              color: widget.tooltipProperty!.textColor, // Set the text color
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;

    // return Container(
    //     child: MyButton(
    //   text: "hi",
    //   onPressed: refresh,
    // ));
  }
}
