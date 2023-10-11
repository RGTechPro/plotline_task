
import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_border.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';
import '../../models/tooltip_model.dart';

class MyToolTip extends StatefulWidget {
  const MyToolTip({super.key, required this.child, this.tooltipProperty
      //required this.refresh
      });

  final Widget child;

  final TooltipProperties? tooltipProperty;
  // VoidCallback refresh;
  @override
  State<MyToolTip> createState() => _MyToolTipState();
}

class _MyToolTipState extends State<MyToolTip> {
  double? leftpos;
  double? rightpos;
  double? toppos;
  double? bottompos;
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
    print("height");
    print(tooltipSize.height);
    overlayEntry?.remove();
    // setRelativePositionToTop(offset!, buttonSize!);
    print("old values");
    print(toppos);
    print(bottompos);
    print(leftpos);
    print(rightpos);
    print("........");
    /////////////////////////
    // Boundary Checks//

    if (leftpos == null) {
      leftpos = screenWidth! - rightpos! - tooltipSize.width;
    } else {
      rightpos = screenWidth! - leftpos! - tooltipSize.width;
    }
    //redo again
    if (toppos == null) {
      toppos = screenHeight! -
          bottompos! -
          tooltipSize.width / widget.tooltipProperty!.aspectRatio;
    } else {
      bottompos = screenHeight! -
          toppos! -
          tooltipSize.width / widget.tooltipProperty!.aspectRatio;
    }
    print(screenHeight);
    print(screenWidth);
    print(toppos);
    print(bottompos);
    print(leftpos);
    print(rightpos);
    //////////////////////////
    switch (widget.tooltipProperty!.tooltipPosition) {
      case TooltipPosition.top:
        //if the tooltip overflows from top then set its position to bottom
        if (toppos! < 0) {
          setRelativePositionToBottom(offset!, buttonSize!);
          newTop = toppos;
        }
        //if it overflows from left then shift the tooltip a bit to right
        if (leftpos! < 0) newLeft = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (rightpos! < 0) newRight = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftpos!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newBottom = bottompos!;
        break;

      case TooltipPosition.left:
        // setRelativePositionToRight(offset!, buttonSize!);
        // bool rightPossible = (leftpos! + tooltipSize.width < screenWidth!);
        // setRelativePositionToLeft(offset!, buttonSize!);
        

        if (leftpos! < 0) {
          setRelativePositionToRight(offset!, buttonSize!);
          

          if (leftpos! + tooltipSize.width > screenWidth!) {
            setRelativePositionToLeft(offset!, buttonSize!);
            newRight = rightpos;
          }
          else{
            newLeft = leftpos;
          }
        }

        //if it overflows from left then shift the tooltip a bit to right
        if (bottompos! < 0) newBottom = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (toppos! < 0) newTop = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newRight = rightpos!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = toppos!;
        break;

      case TooltipPosition.right:
        if (rightpos! < 0) {
          setRelativePositionToLeft(offset!, buttonSize!);
          if (rightpos! + tooltipSize.width > screenWidth!) {
            setRelativePositionToRight(offset!, buttonSize!);
            newLeft = leftpos;
          }
          else{
            newRight = rightpos;
          }
        }
        
        //if it overflows from left then shift the tooltip a bit to right
        if (bottompos! < 0) newBottom = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (toppos! < 0) newTop = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftpos!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = toppos!;

        break;
      case TooltipPosition.bottom:
        if (bottompos! < 0) {
          setRelativePositionToTop(offset!, buttonSize!);
          newBottom = bottompos;
        }
        //if it overflows from left then shift the tooltip a bit to right
        if (leftpos! < 0) newLeft = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (rightpos! < 0) newRight = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftpos!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = toppos!;
        break;
      case TooltipPosition.auto:
        if (bottompos! < 0) {
          setRelativePositionToTop(offset!, buttonSize!);
          newBottom = bottompos;
        }
        //if it overflows from left then shift the tooltip a bit to right
        if (leftpos! < 0) newLeft = 0;
        //if it overflows from right then shift the tooltip a bit to left
        if (rightpos! < 0) newRight = 0;

        //check if both left and right are null then set either
        if (newLeft == null && newRight == null) newLeft = leftpos!;
        //check if both top and bottom are null then set either
        if (newBottom == null && newTop == null) newTop = toppos!;
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
    // leftpos =
    //     offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;
    // rightpos = leftpos! + widget.tooltipProperty!.tooltipWidth;
    //func above
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
            left: leftpos,
            right: rightpos,
            top: toppos,
            bottom: bottompos,
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
    // final renderBox = tooltipKey.currentContext!.findRenderObject() as RenderBox;
    // final size = renderBox.size;
    // print(size);
//     //readjustment vertically
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     //readjustment of top
//     if (toppos !< 0) {
//       newTooltipPosition = TooltipPosition.bottom;
//       setRelativePositionToBottom(offset, size);
//     }
//     //readjustment of bottom
//     if (screenHeight - toppos! < 35) {
//       newTooltipPosition = TooltipPosition.top;
//       setRelativePositionToTop(offset,size);
//     }
//     ///////

// //readjustment horizontally
//     if (rightpos! > screenWidth) {
//       leftpos = leftpos! - (rightpos! - screenWidth);
//     }
//     if (leftpos! < 0) {
//       leftpos = 0;
//     }

    return newTooltipPosition;
  }

  void setRelativePositionToTop(Offset offset, Size size) {
    // toppos = offset.dy - 135 - widget.tooltipProperty!.arrowHeight;
    newTooltipPosition = TooltipPosition.top;
    double screenHeight = MediaQuery.of(context).size.height;
    leftpos =
        offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;
    bottompos = screenHeight - offset.dy + widget.tooltipProperty!.arrowHeight;
  }

  void setRelativePositionToLeft(Offset offset, Size size) {
    // leftpos = offset.dx -
    //     widget.tooltipProperty!.tooltipWidth -
    //     widget.tooltipProperty!.arrowHeight;
    newTooltipPosition = TooltipPosition.left;
    double screenWidth = MediaQuery.of(context).size.width;
    rightpos = screenWidth - offset.dx + widget.tooltipProperty!.arrowHeight;

    toppos = offset.dy + 5;
  }

  void setRelativePositionToRight(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.right;
    leftpos = offset.dx + size.width + widget.tooltipProperty!.arrowHeight;
    toppos = offset.dy + 5;
  }

  void setRelativePositionToBottom(Offset offset, Size size) {
    newTooltipPosition = TooltipPosition.bottom;
    leftpos =
        offset.dx - widget.tooltipProperty!.tooltipWidth / 2 + size.width / 2;
    toppos = offset.dy + size.height + widget.tooltipProperty!.arrowHeight;
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

    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   child: CustomSingleChildLayout(
    //       delegate: _TooltipPositionDelegate(
    //         target: Offset(10, 10),
    //         verticalOffset: 10,
    //         preferBelow: true,
    //       ),
    //       child: tooltipContent),
    // );
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
