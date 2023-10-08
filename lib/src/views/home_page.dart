import 'package:flutter/material.dart';
import 'package:plotline_task/src/widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    MyButton(text: 'Button 1', onPressed: () {}),
                    MyButton(text: 'Button 2', onPressed: () {})
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(text: 'Button 3', onPressed: () {}),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(text: 'Button 4', onPressed: () {}),
                    MyButton(text: 'Button 5', onPressed: () {})
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
