
import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_border.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';
import '../../models/tooltip_model.dart';

class MyToolTip extends StatefulWidget {
  const MyToolTip({super.key, required this.child, this.tooltipProperty
      });

  final Widget child;

  final TooltipProperties? tooltipProperty;
  @override
  State<MyToolTip> createState() => _MyToolTipState();
}

class _MyToolTipState extends State<MyToolTip> {
  double? leftPosition;
  double? rightPosition;
  double? topPosition;
  double? bottomPosition;
  OverlayEntry? overlayEntry;
  OverlayEntry? dummyOverlayEntry;
  GlobalKey tooltipKey = GlobalKey();
  OverlayState? overlay;
  TooltipPosition? newTooltipPosition;
  Size? buttonSize;
  Offset? offset;
  int counter = 0;
  double? screenHeight;
  double? screenWidth;
  double? newTop;
  double? newBottom;
  double? newLeft;
  double? newRight;
  @override
  void initState() {
    super.initState();

    refresh();
  }

  void readjust2() async {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final renderBox =
        tooltipKey.currentContext?.findRenderObject() as RenderBox;
    // await Future.delayed(const Duration(milliseconds: 100));
    final tooltipSize = renderBox.size;

    overlayEntry?.remove();
    // setRelativePositionToTop(offset!, buttonSize!);

    /////////////////////////
    // Boundary Checks//

    if (leftPosition == null) {
      leftPosition = screenWidth! - rightPosition! - tooltipSize.width;
    } else {
      rightPosition = screenWidth! - leftPosition! - tooltipSize.width;
    }
    //redo again
    if (topPosition == null) {
      topPosition = screenHeight! -
          bottomPosition! -
          tooltipSize.width / widget.tooltipProperty!.aspectRatio!;
    } else {
      bottomPosition = screenHeight! -
          topPosition! -
          tooltipSize.width / widget.tooltipProperty!.aspectRatio!;
    }

    //////////////////////////
    switch (widget.tooltipProperty!.tooltipPosition) {
      case TooltipPosition.top:
        //if the tooltip overflows from top then set its position to bottom
        if (topPosition! < 0) {
          setRelativePositionToBottom(offset!, buttonSize!);
          newTop = topPosition;
        }
        //if it overflows from left then shift the tooltip a bit to right
        if (leftPosition! < 0) newLeft = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (rightPosition! < 0) newRight = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftPosition!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newBottom = bottomPosition!;
        break;

      case TooltipPosition.left:
  

        if (leftPosition! < 0) {
          setRelativePositionToRight(offset!, buttonSize!);
          

          if (leftPosition! + tooltipSize.width > screenWidth!) {
            setRelativePositionToLeft(offset!, buttonSize!);
            newRight = rightPosition;
          }
          else{
            newLeft = leftPosition;
          }
        }

        //if it overflows from left then shift the tooltip a bit to right
        if (bottomPosition! < 0) newBottom = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (topPosition! < 0) newTop = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newRight = rightPosition!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = topPosition!;
        break;

      case TooltipPosition.right:
        if (rightPosition! < 0) {
          setRelativePositionToLeft(offset!, buttonSize!);
          if (rightPosition! + tooltipSize.width > screenWidth!) {
            setRelativePositionToRight(offset!, buttonSize!);
            newLeft = leftPosition;
          }
          else{
            newRight = rightPosition;
          }
        }
        
        //if it overflows from left then shift the tooltip a bit to right
        if (bottomPosition! < 0) newBottom = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (topPosition! < 0) newTop = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftPosition!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = topPosition!;

        break;
      case TooltipPosition.bottom:
        if (bottomPosition! < 0) {
          setRelativePositionToTop(offset!, buttonSize!);
          newBottom = bottomPosition;
        }
        //if it overflows from left then shift the tooltip a bit to right
        if (leftPosition! < 0) newLeft = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (rightPosition! < 0) newRight = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftPosition!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = topPosition!;
        break;
      case TooltipPosition.auto:
        if (bottomPosition! < 0) {
          setRelativePositionToTop(offset!, buttonSize!);
          newBottom = bottomPosition;
        }
        //if it overflows from left then shift the tooltip a bit to right
        if (leftPosition! < 0) newLeft = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (rightPosition! < 0) newRight = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftPosition!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = topPosition!;
        break;
    }
    //////////////////////////

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
            left: newLeft,
            right: newRight,
            top: newTop,
            bottom: newBottom,
            child: buildOverlay(tooltipPosition: newTooltipPosition!));
      },
    );
    if (widget.tooltipProperty?.isHidden == false) {
      overlay!.insert(overlayEntry!);
    }
  }

  @override
  void dispose() {
    print('stae is disposng');
    removeOverlay();

    print('state is disposed');
    super.dispose();
  }

//refresh chng nae
  void refresh() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
    }
  }

  void showOverlay() {
    if (!mounted) return;
    overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);

    switch (widget.tooltipProperty!.tooltipPosition) {
      case TooltipPosition.top:
        setRelativePositionToTop(offset!, buttonSize!);

        break;
      case TooltipPosition.left:
        setRelativePositionToLeft(offset!, buttonSize!);

        break;
      case TooltipPosition.right:
        setRelativePositionToRight(offset!, buttonSize!);
        break;
      case TooltipPosition.bottom:
        setRelativePositionToBottom(offset!, buttonSize!);
      case TooltipPosition.auto:
        setRelativePositionToBottom(offset!, buttonSize!);

        break;
      default:
        setRelativePositionToBottom(offset!, buttonSize!);
    }
    newTooltipPosition = readjust(offset!, buttonSize!);
    if (!mounted) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
            left: leftPosition,
            right: rightPosition,
            top: topPosition,
            bottom: bottomPosition,
            child: buildOverlay(tooltipPosition: newTooltipPosition!));
      },
    );
    if (widget.tooltipProperty?.isHidden == false) {
      overlay!.insert(overlayEntry!);
    }
  }

  TooltipPosition readjust(Offset offset, Size size) {
    TooltipPosition newTooltipPosition =
        widget.tooltipProperty!.tooltipPosition;

    return newTooltipPosition;
  }

   // Function to set relative position of the tooltip to the top of the target widget
  void setRelativePositionToTop(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.top;
    double screenHeight = MediaQuery.of(context).size.height;
    
    // Calculate the left position to center the tooltip horizontally
    leftPosition = offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;
    
    // Calculate the bottom position with extra height for the tooltip's arrow
    bottomPosition = screenHeight - offset.dy + widget.tooltipProperty!.arrowHeight;
  }

  // Function to set relative position of the tooltip to the left of the target widget
  void setRelativePositionToLeft(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.left;
    double screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate the right position with extra width for the tooltip's arrow
    rightPosition = screenWidth - offset.dx + widget.tooltipProperty!.arrowHeight;

    // Calculate the top position, adding a margin from the top
    topPosition = offset.dy + 5;
  }

  // Function to set relative position of the tooltip to the right of the target widget
  void setRelativePositionToRight(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.right;
    
    // Calculate the left position with extra width for the tooltip's arrow
    leftPosition = offset.dx + size.width + widget.tooltipProperty!.arrowHeight;
    
    // Calculate the top position, adding a margin from the top
    topPosition = offset.dy + 5;
  }

  // Function to set relative position of the tooltip to the bottom of the target widget
  void setRelativePositionToBottom(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.bottom;
    
    // Calculate the left position to center the tooltip horizontally
    leftPosition = offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;
    
    // Calculate the top position, adding the widget's height and an extra height for the tooltip's arrow
    topPosition = offset.dy + size.height + widget.tooltipProperty!.arrowHeight;
  }

  void removeOverlay() {
    if (overlayEntry != null && overlayEntry!.mounted) {
      overlayEntry?.remove();

      overlayEntry = null;
    }
  }

  Widget buildOverlay({required TooltipPosition tooltipPosition}) {
    final renderBox = context.findRenderObject() as RenderBox;
    Widget tooltipContent = Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          overlayEntry!.remove();
        },
        child: Container(
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
          padding: EdgeInsets.all(widget.tooltipProperty!.padding),
          child: Column(
            children: [
              Text(
                widget.tooltipProperty!.tooltipText,
                style: TextStyle(
                  fontSize: widget.tooltipProperty!.textSize,
                  color:
                      widget.tooltipProperty!.textColor, // Set the text color
                ),
              ),
              (widget.tooltipProperty!.image != null)
                  ? ClipRRect(
                      child: Image.memory(widget.tooltipProperty!.image!))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );


    return TooltipBox(
        readjust2: readjust2, tooltipContent: tooltipContent, key: tooltipKey);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.child,
      ],
    );

  }
}



class TooltipBox extends StatefulWidget {
  const TooltipBox(
      {super.key, required this.readjust2, required this.tooltipContent});
  final VoidCallback? readjust2;
  final Widget? tooltipContent;
  @override
  State<TooltipBox> createState() => _TooltipBoxState();
}

class _TooltipBoxState extends State<TooltipBox> {
  @override
  void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.readjust2!());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.tooltipContent!;
  }
}
