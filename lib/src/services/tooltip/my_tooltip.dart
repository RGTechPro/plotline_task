import 'package:flutter/material.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_border.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';

class MyToolTip extends StatefulWidget {
  const MyToolTip(
      {super.key,
      required this.child,
      this.tooltipPosition = TooltipPosition.auto});

  final Widget child;
  final TooltipPosition tooltipPosition;
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

    toppos = offset.dy + size.height;
    if (widget.tooltipPosition == TooltipPosition.top) {
      setRelativePositionToTop(offset);
    }
    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(left: leftpos, top: toppos, child: buildOverlay());
      },
    );
    overlay.insert(entry);
  }

  void setRelativePositionToTop(Offset offset) {
  
    toppos = offset.dy-35;
  }

  Widget buildOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    return Container(
      height: 35,
      width: 250,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: TooltipBorder(
            renderBox: renderBox, tooltipPosition: widget.tooltipPosition),
        shadows: const [
          BoxShadow(color: Colors.black, blurRadius: 4.0, offset: Offset(2, 2)),
        ],
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 8),
      child: const Text(
        'Tooltip text goes here',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white, // Set the text color
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
