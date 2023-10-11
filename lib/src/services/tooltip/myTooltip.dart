import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltipBorder.dart';
import 'package:plotline_task/src/services/tooltip/tooltipPosition.dart';

import '../../models/tooltip_model.dart';

class MyToolTip extends StatefulWidget {
  const MyToolTip({super.key, required this.child, this.tooltipProperty});

  final Widget child;

  final TooltipProperties? tooltipProperty;
  @override
  State<MyToolTip> createState() => _MyToolTipState();
}

class _MyToolTipState extends State<MyToolTip> {
  double? leftPosition; // Stores the left position of the tooltip.
  double? rightPosition; // Stores the right position of the tooltip.
  double? topPosition; // Stores the top position of the tooltip.
  double? bottomPosition; // Stores the bottom position of the tooltip.
  OverlayEntry? overlayEntry; // Entry for the tooltip in the overlay.
  GlobalKey tooltipKey =
      GlobalKey(); // A global key to identify the tooltip widget.
  OverlayState? overlay; // The overlay where the tooltip will be displayed.
  TooltipPosition?
      newTooltipPosition; // Stores the new position of the tooltip.
  Size? buttonSize; // Size of the button that triggers the tooltip.
  Offset? offset; // Offset position for the tooltip.
  double? screenHeight; // Stores the height of the screen.
  double? screenWidth; // Stores the width of the screen.
  double? newTop; // New top position for the tooltip.
  double? newBottom; // New bottom position for the tooltip.
  double? newLeft; // New left position for the tooltip.
  double? newRight; // New right position for the tooltip.
  Size? tooltipSize = const Size(0, 0);
  @override
  void initState() {
    super.initState();

    // Initialize the overlay when the widget is first created.
    initiateOverlay();
  }

  @override
  void dispose() {
    // Remove the overlay when the widget is disposed.
    removeOverlay();

    super.dispose();
  }

  void initiateOverlay() {
    if (mounted) {
      // Add a post-frame callback to show the overlay.
      WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
    }
  }

  void showOverlay() {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // Get the overlay state from the current context.
    overlay = Overlay.of(context);

    // Find the render box of the context to determine the button's size and offset.
    final renderBox = context.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);

    // Determine the tooltip position and set relative positioning accordingly.
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
        break;
      case TooltipPosition.auto:
        setRelativePositionToBottom(offset!, buttonSize!);
        break;
      default:
        setRelativePositionToBottom(offset!, buttonSize!);
    }

    // Create an overlay entry to display the tooltip.
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: leftPosition,
          right: rightPosition,
          top: topPosition,
          bottom: bottomPosition,
          child: buildOverlay(tooltipPosition: newTooltipPosition!),
        );
      },
    );

    // Insert the overlay entry if the tooltip is not hidden.
    if (widget.tooltipProperty?.isHidden == false) {
      overlay!.insert(overlayEntry!);
    }
  }

  // Function to set relative position of the tooltip to the top of the target widget
  void setRelativePositionToTop(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.top;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the left position to center the tooltip horizontally
    leftPosition =
        offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;

    // Calculate the bottom position with extra height for the tooltip's arrow
    bottomPosition =
        screenHeight - offset.dy + widget.tooltipProperty!.arrowHeight;
  }

  // Function to set relative position of the tooltip to the left of the target widget
  void setRelativePositionToLeft(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.left;

    // Calculate the right position with extra width for the tooltip's arrow
    rightPosition =
        screenWidth! - offset.dx + widget.tooltipProperty!.arrowHeight;

    // Calculate the top position, adding a margin from the top
    topPosition = offset.dy + size.height / 2 - tooltipSize!.height / 2;
  }

  // Function to set relative position of the tooltip to the right of the target widget
  void setRelativePositionToRight(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.right;

    // Calculate the left position with extra width for the tooltip's arrow
    leftPosition = offset.dx + size.width + widget.tooltipProperty!.arrowHeight;

    // Calculate the top position, adding a margin from the top
    topPosition = offset.dy + size.height / 2 - tooltipSize!.height / 2;
  }

  // Function to set relative position of the tooltip to the bottom of the target widget
  void setRelativePositionToBottom(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.bottom;

    // Calculate the left position to center the tooltip horizontally
    leftPosition =
        offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;

    // Calculate the top position, adding the widget's height and an extra height for the tooltip's arrow
    topPosition = offset.dy + size.height + widget.tooltipProperty!.arrowHeight;
  }

  void readjust() {
    // Get the screen dimensions using MediaQuery.
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // Find the render box of the tooltip.
    final renderBox =
        tooltipKey.currentContext?.findRenderObject() as RenderBox;

    tooltipSize = renderBox.size;

    overlayEntry?.remove();

    // Boundary Checks for tooltip positioning.
    calculatePositions();
    // Handle different tooltip positions.

    switch (widget.tooltipProperty!.tooltipPosition) {
      case TooltipPosition.top:
        // If the tooltip overflows from the top, adjust its position to bottom.
        readjustTop();
        break;

      case TooltipPosition.left:
        // Readjust the tooltip for the left position.
        readjustLeft(tooltipSize!);
        break;

      case TooltipPosition.right:
        // Readjust the tooltip for the right position.
        readjustRight(tooltipSize!);
        break;
      case TooltipPosition.bottom:
        // Readjust the tooltip for the bottom position.
        readjustBottom(tooltipSize!);
        break;
      case TooltipPosition.auto:
        // Readjust the tooltip for the auto position.
        readjustAuto(tooltipSize!);
        break;
    }

    // Create a new overlay entry with the adjusted position.
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

    // Insert the overlay entry if the tooltip is not hidden.
    if (widget.tooltipProperty?.isHidden == false) {
      overlay!.insert(overlayEntry!);
    }
  }

  void readjustTop() {
    setRelativePositionToTop(offset!, buttonSize!);
    if (topPosition! < 0) {
      setRelativePositionToBottom(offset!, buttonSize!);
      newTop = topPosition;
    }
    calculatePositions();
    //if it overflows from left then shift the tooltip a bit to right
    if (leftPosition! < 0) newLeft = 0;
    //if it overflows from right then shift the tooltip a bit to left
    if (rightPosition! < 0) newRight = 0;

    //check if both left and right are null then set either
    if (newLeft == null && newRight == null) newLeft = leftPosition!;
    //check if both top and bottom are null then set either
    if (newBottom == null && newTop == null) newBottom = bottomPosition!;
  }

  void readjustLeft(Size tooltipSize) {
    setRelativePositionToLeft(offset!, buttonSize!);
    // Check if the tooltip's left position is outside the screen boundary.
    if (leftPosition! < 0) {
      // Adjust the tooltip position to be relative to the right side of the target element.
      setRelativePositionToRight(offset!, buttonSize!);

      // Check if the adjusted left position plus the tooltip's width exceeds the screen width.
      if (leftPosition! + tooltipSize.width > screenWidth!) {
        // If the tooltip overflows the right side, adjust its position to the left.
        setRelativePositionToLeft(offset!, buttonSize!);
        newRight = rightPosition;
      } else {
        // Otherwise, set the newLeft to the adjusted left position.
        newLeft = leftPosition;
      }
    }
    calculatePositions();
    //if it overflows from left then shift the tooltip a bit to right
    if (bottomPosition! < 0) newBottom = 0;
    //if it overflows from right then shift the tooltip a bit to left
    if (topPosition! < 0) newTop = 0;

    //check if both left and right are null then set either
    if (newLeft == null && newRight == null) newRight = rightPosition!;
    //check if both top and bottom are null then set either
    if (newBottom == null && newTop == null) newTop = topPosition!;
  }

  void readjustRight(Size tooltipSize) {
    setRelativePositionToRight(offset!, buttonSize!);
    if (rightPosition! < 0) {
      setRelativePositionToLeft(offset!, buttonSize!);
      if (rightPosition! + tooltipSize.width > screenWidth!) {
        setRelativePositionToRight(offset!, buttonSize!);
        newLeft = leftPosition;
      } else {
        newRight = rightPosition;
      }
    }
    calculatePositions();
    //if it overflows from left then shift the tooltip a bit to right
    if (bottomPosition! < 0) newBottom = 0;
    //if it overflows from right then shift the tooltip a bit to left
    if (topPosition! < 0) newTop = 0;

    //check if both left and right are null then set either
    if (newLeft == null && newRight == null) newLeft = leftPosition!;
    //check if both top and bottom are null then set either
    if (newBottom == null && newTop == null) newTop = topPosition!;
  }

  void readjustBottom(Size tooltipSize) {
    setRelativePositionToBottom(offset!, buttonSize!);
// Check if the tooltip's bottom position is above the screen boundary.
    if (bottomPosition! < 0) {
      // Adjust the tooltip position to be at the top.
      setRelativePositionToTop(offset!, buttonSize!);

      // Update the newBottom to the adjusted bottom position.
      newBottom = bottomPosition;
    }
    calculatePositions();
    //if it overflows from left then shift the tooltip a bit to right
    if (leftPosition! < 0) newLeft = 0;
    //if it overflows from right then shift the tooltip a bit to left
    if (rightPosition! < 0) newRight = 0;

    //check if both left and right are null then set either
    if (newLeft == null && newRight == null) newLeft = leftPosition!;
    //check if both top and bottom are null then set either
    if (newBottom == null && newTop == null) newTop = topPosition!;
  }

  void readjustAuto(Size tooltipSize) {
    setRelativePositionToBottom(offset!, buttonSize!);
// Check if the tooltip's bottom position is above the screen boundary.
    if (bottomPosition! < 0) {
      // Adjust the tooltip position to be at the top.
      setRelativePositionToTop(offset!, buttonSize!);

      // Update the newBottom to the adjusted bottom position.
      newBottom = bottomPosition;
    }
    calculatePositions();
    //if it overflows from left then shift the tooltip a bit to right
    if (leftPosition! < 0) newLeft = 0;
    //if it overflows from right then shift the tooltip a bit to left
    if (rightPosition! < 0) newRight = 0;

    //check if both left and right are null then set either
    if (newLeft == null && newRight == null) newLeft = leftPosition!;
    //check if both top and bottom are null then set either
    if (newBottom == null && newTop == null) newTop = topPosition!;
  }

  void calculatePositions() {
    // Check if leftPosition is null and calculate it based on rightPosition and tooltip size.
    // Otherwise, calculate rightPosition based on leftPosition and tooltip size.
    if (leftPosition == null) {
      leftPosition = screenWidth! - rightPosition! - tooltipSize!.width;
    } else {
      rightPosition = screenWidth! - leftPosition! - tooltipSize!.width;
    }

    // Check if topPosition is null and calculate it based on bottomPosition and aspect ratio.
    // Otherwise, calculate bottomPosition based on topPosition and aspect ratio.
    if (topPosition == null) {
      topPosition = screenHeight! -
          bottomPosition! -
          tooltipSize!.height -
          tooltipSize!.width / widget.tooltipProperty!.aspectRatio!;
    } else {
      bottomPosition = screenHeight! -
          topPosition! -
          tooltipSize!.height -
          tooltipSize!.width / widget.tooltipProperty!.aspectRatio!;
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
        readjust: readjust, tooltipContent: tooltipContent, key: tooltipKey);
  }

  void removeOverlay() {
    if (overlayEntry != null && overlayEntry!.mounted) {
      overlayEntry?.remove();

      overlayEntry = null;
    }
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
      {super.key, required this.readjust, required this.tooltipContent});
  final VoidCallback? readjust;
  final Widget? tooltipContent;
  @override
  State<TooltipBox> createState() => _TooltipBoxState();
}

class _TooltipBoxState extends State<TooltipBox> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.readjust!());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.tooltipContent!;
  }
}
