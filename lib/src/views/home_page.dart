import 'package:flutter/material.dart';
import 'package:plotline_task/src/models/tooltip_model.dart';
import 'package:plotline_task/src/services/tooltip/my_tooltip.dart';
import 'package:plotline_task/src/views/tooltip_renderer.dart';
import 'package:plotline_task/src/widgets/button.dart';

import '../services/tooltip/tooltip_position.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.tooltipProperties});
  final List<TooltipProperties>? tooltipProperties;
  TooltipPosition bjkb = TooltipPosition.top;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffB8B8B8),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyToolTip(
                        tooltipProperty: tooltipProperties![0],
                        child: MyButton(
                            text: 'Button 1',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TooltipForm(
                                            buttonText: 'Button 1',
                                          )));
                            })),
                    MyToolTip(
                        tooltipProperty: tooltipProperties![1],
                        child: MyButton(
                            text: 'Button 2',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TooltipForm(
                                            buttonText: 'Button 2',
                                          )));
                            }))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyToolTip(
                        tooltipProperty: tooltipProperties![2],
                        child: MyButton(
                            text: 'Button 3',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TooltipForm(
                                            buttonText: 'Button 3',
                                          )));
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        text: 'Button 3',
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TooltipForm(
                                        buttonText: 'Button hsdgfhjs',
                                      )));
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyToolTip(
                        tooltipProperty: tooltipProperties![3],
                        child: MyButton(
                            text: 'Button 4',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TooltipForm(
                                            buttonText: 'Button 4',
                                          )));
                            })),
                    MyToolTip(
                        tooltipProperty: tooltipProperties![4],
                        child: MyButton(
                            text: 'Button 5',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TooltipForm(
                                            buttonText: 'Button 5',
                                          )));
                            }))
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
