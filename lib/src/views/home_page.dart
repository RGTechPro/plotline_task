import 'package:flutter/material.dart';
import 'package:plotline_task/src/models/tooltip_model.dart';
import 'package:plotline_task/src/services/tooltip/my_tooltip.dart';
import 'package:plotline_task/src/widgets/button.dart';

import '../services/tooltip/tooltip_position.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.tooltipProperty});
  final TooltipProperties? tooltipProperty;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TooltipPosition bjkb = TooltipPosition.top;
  List<TooltipProperties> tooltipProperties = [];
  @override
  void initState() {
    tooltipProperties.add(widget.tooltipProperty!);
    super.initState();
  }

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
                      
                      
                       tooltipProperty: tooltipProperties.firstWhere((element) => element.targetElement=='Button 1'),
                     //  tooltipProperty: tooltipProperties[0],
                        child: MyButton(text: 'Button 1', onPressed: () {})),
                    MyToolTip(
                   
                       
                                               // tooltipProperty: tooltipProperties.firstWhere((element) => element.targetElement=='Button 2'),
                        child: MyButton(text: 'Button 2', onPressed: () {}))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyToolTip(
          
                       
                                             //   tooltipProperty: tooltipProperties.firstWhere((element) => element.targetElement=='Button 1'),
                        child: MyButton(text: 'Button 3', onPressed: () {})),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyToolTip(
                    
                      
                                              //  tooltipProperty: tooltipProperties.firstWhere((element) => element.targetElement=='Button 1'),
                        child: MyButton(text: 'Button 4', onPressed: () {})),
                    MyToolTip(
                     
                       
                                             //   tooltipProperty: tooltipProperties.firstWhere((element) => element.targetElement=='Button 1'),
                        child: MyButton(text: 'Button 5', onPressed: () {}))
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
