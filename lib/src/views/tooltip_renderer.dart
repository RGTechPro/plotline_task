import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plotline_task/src/constants.dart';
import 'package:plotline_task/src/models/tooltip_model.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';
import 'package:plotline_task/src/views/home_page.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/my_color_picker.dart';

class TooltipForm extends StatefulWidget {
  const TooltipForm({super.key});

  @override
  _TooltipFormState createState() => _TooltipFormState();
}

class _TooltipFormState extends State<TooltipForm> {
  final _formKey = GlobalKey<FormState>();

  final targetElementController = TextEditingController(text: 'Button 1');

  final tooltipTextController = TextEditingController();
  final textSizeController = TextEditingController();
  final paddingController = TextEditingController();
  final cornerRadiusController = TextEditingController();
  final tooltipWidthController = TextEditingController();
  final arrowWidthController = TextEditingController();
  final arrowHeightController = TextEditingController();
  TooltipPosition? tooltipPosition = TooltipPosition.auto;
  String selectedTooltipPosition = 'auto'; // Default position
  Color textColor = Colors.white;
  Color backgroundColor = Colors.black;
  XFile? image;
  @override
  void dispose() {
    targetElementController.dispose();
    tooltipTextController.dispose();
    textSizeController.dispose();
    paddingController.dispose();
    cornerRadiusController.dispose();
    tooltipWidthController.dispose();
    arrowWidthController.dispose();
    arrowHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Target Element',
                    style: kFormLabelTextStyle,
                  ),
                ),

                DropdownButtonFormField<String>(
                  decoration: kFromInputDecoration,
                  value: targetElementController.text.isEmpty
                      ? null
                      : targetElementController.text,
                  items: [
                    'Button 1',
                    'Button 2',
                    'Button 3',
                    'Button 4',
                    'Button 5'
                  ].map((element) {
                    return DropdownMenuItem<String>(
                      value: element,
                      child: Text(element),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      targetElementController.text = value!;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Tooltip Text',
                    style: kFormLabelTextStyle,
                  ),
                ),
                TextFormField(
                  controller: tooltipTextController,
                  decoration: kFromInputDecoration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter tooltip text';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Text Size',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          TextFormField(
                            controller: textSizeController,
                            decoration: kFromInputDecoration,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter text size';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Padding',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          TextFormField(
                            controller: paddingController,
                            decoration: kFromInputDecoration,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter padding';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Corner Radius',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          TextFormField(
                            controller: cornerRadiusController,
                            decoration: kFromInputDecoration,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter corner radius';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Tooltip Width',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          TextFormField(
                            controller: tooltipWidthController,
                            decoration: kFromInputDecoration,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter tooltip width';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Arrow Width',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          TextFormField(
                            controller: arrowWidthController,
                            decoration: kFromInputDecoration,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter arrow width';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Arrow Height',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          TextFormField(
                            controller: arrowHeightController,
                            decoration: kFromInputDecoration,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter arrow height';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Text Color',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyColorPicker(
                                onSelectColor: (value) {
                                  setState(() {
                                    textColor = value;
                                  });
                                },
                                availableColors: const [
                                  Colors.white,
                                  Colors.black,
                                  Colors.blue,
                                  Colors.green,
                                  Colors.greenAccent,
                                  Colors.yellow,
                                  Colors.orange,
                                  Colors.red,
                                  Colors.purple,
                                  Colors.grey,
                                ],
                                initialColor: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Background Color',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyColorPicker(
                                onSelectColor: (value) {
                                  setState(() {
                                    backgroundColor = value;
                                  });
                                },
                                availableColors: const [
                                  Colors.black,
                                  Colors.white,
                                  Colors.blue,
                                  Colors.green,
                                  Colors.greenAccent,
                                  Colors.yellow,
                                  Colors.orange,
                                  Colors.red,
                                  Colors.purple,
                                  Colors.grey,
                                ],
                                initialColor: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Tooltip Position',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            decoration: kFromInputDecoration,
                            value: selectedTooltipPosition,
                            items: ['top', 'bottom', 'right', 'left', 'auto']
                                .map((position) {
                              return DropdownMenuItem<String>(
                                value: position,
                                child: Text(position),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedTooltipPosition = value!;
                               tooltipPosition = TooltipPosition.values
                                    .firstWhere(
                                        (e) => e.name == selectedTooltipPosition);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Select image',
                              style: kFormLabelTextStyle,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await pickImage();
                            },
                            child: Container(
                              height: 45,
                              width: 180,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffD9D9D9)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.image),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                // Add Tooltip Image Input here
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          backgroundColor: const Color(0xFF0B58D9),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            tooltipProperty: TooltipProperties(
                                                targetElement:
                                                    targetElementController
                                                        .text,
                                                tooltipText:
                                                    tooltipTextController.text,
                                                textSize: double.parse(
                                                    textSizeController.text),
                                                padding: double.parse(
                                                    paddingController.text),
                                                textColor: textColor,
                                                backgroundColor:
                                                    backgroundColor,
                                                cornerRadius: double.parse(
                                                    cornerRadiusController
                                                        .text),
                                                tooltipWidth: double.parse(
                                                    tooltipWidthController
                                                        .text),
                                                arrowWidth: double.parse(
                                                    arrowHeightController.text),
                                                arrowHeight: double.parse(
                                                  arrowHeightController.text,
                                                ),
                                                tooltipPosition:
                                                    tooltipPosition!),
                                          )));
                            }
                          }
                        },
                        child: const Text(
                          'Render Tooltip',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
