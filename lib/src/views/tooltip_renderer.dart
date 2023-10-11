import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plotline_task/src/models/tooltip_model.dart';
import 'package:plotline_task/src/services/tooltip/default_properties.dart';
import 'package:plotline_task/src/services/tooltip/tooltip_position.dart';
import 'package:plotline_task/src/views/home_page.dart';

import '../widgets/colorPicker.dart';
import '../widgets/formFieldwithLabel.dart';
import '../widgets/imagePicker.dart';
import '../widgets/textFormField.dart';

class TooltipForm extends StatefulWidget {
  const TooltipForm({super.key, this.buttonText = 'Button 1'});
  final String buttonText;
  @override
  _TooltipFormState createState() => _TooltipFormState();
}

class _TooltipFormState extends State<TooltipForm> {
  final _formKey = GlobalKey<FormState>();
  // List of selected properties that will be passed on to HomePage
  // Set to default properties in services/tooltip/default_properties.dart
  List<TooltipProperties> properties = defaultProperties;
  int idx = 0;
  // Initial target element is 'Button 1'
  final targetElementController =
      TextEditingController(text: defaultProperties[0].targetElement);

  // Defining the controllers for the form fields
  final tooltipTextController =
      TextEditingController(text: defaultProperties[0].tooltipText);
  final textSizeController =
      TextEditingController(text: defaultProperties[0].textSize.toString());
  final paddingController =
      TextEditingController(text: defaultProperties[0].padding.toString());
  final cornerRadiusController =
      TextEditingController(text: defaultProperties[0].cornerRadius.toString());
  final tooltipWidthController =
      TextEditingController(text: defaultProperties[0].tooltipWidth.toString());
  final arrowWidthController =
      TextEditingController(text: defaultProperties[0].arrowWidth.toString());
  final arrowHeightController =
      TextEditingController(text: defaultProperties[0].arrowHeight.toString());
  final tooltipPositionController =
      TextEditingController(text: defaultProperties[0].tooltipPosition.name);

  TooltipPosition? tooltipPosition = TooltipPosition.auto;
  String selectedTooltipPosition = 'auto'; // Default position
  Color textColor = Colors.white; // write initial
  Color backgroundColor = Colors.black;
  Uint8List? image;

  double aspectRatio = 1;

  List<String> buttons = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
    'Button 5'
  ];

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
  void initState() {
    targetElementController.text = widget.buttonText;
    super.initState();
  }

  // Used to set the properties list to the controller values
  void setProperties() {
    // Mapping the current target element to an index

    idx = buttons
        .indexWhere((element) => element == targetElementController.text);
    // Setting the properties list to controller values of the target element
    properties[idx!] = TooltipProperties(
        isHidden: false,
        targetElement: targetElementController.text,
        tooltipText: tooltipTextController.text,
        textSize: double.parse(textSizeController.text),
        padding: double.parse(paddingController.text),
        textColor: textColor,
        backgroundColor: backgroundColor,
        cornerRadius: double.parse(cornerRadiusController.text),
        tooltipWidth: double.parse(tooltipWidthController.text),
        arrowWidth: double.parse(arrowHeightController.text),
        arrowHeight: double.parse(
          arrowHeightController.text,
        ),
        tooltipPosition: tooltipPosition!,
        image: image,
        aspectRatio: aspectRatio!);
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
                // ---------- Target Element Selector ----------
                FormFieldWithLabel(
                  label: 'Target Element',
                  items: buttons,

                  // useless condituion
                  value: targetElementController.text.isEmpty
                      ? null
                      : targetElementController.text,
                  onChanged: (value) {
                    //   setProperties();
                    setState(() {
                      idx = buttons.indexWhere((element) => element == value);
                      targetElementController.text = value!;
                      tooltipTextController.text = properties[idx].tooltipText;
                      textSizeController.text =
                          properties[idx].textSize.toString();
                      paddingController.text =
                          properties[idx].padding.toString();
                      cornerRadiusController.text =
                          properties[idx].cornerRadius.toString();
                      tooltipWidthController.text =
                          properties[idx].tooltipWidth.toString();
                      arrowWidthController.text =
                          properties[idx].arrowWidth.toString();
                      arrowHeightController.text =
                          properties[idx].arrowHeight.toString();
                      tooltipPositionController.text =
                          properties[idx].tooltipPosition.name;
                      image = properties[idx].image;
                      selectedTooltipPosition =
                          properties[idx].tooltipPosition.name;
                      textColor = properties[idx].textColor;
                      backgroundColor = properties[idx].backgroundColor;
                    });
                  },
                  controller: targetElementController,
                ),

                // ---------- Text to be displayed in the tooltip ----------
                TextFormWithLabel(
                  label: 'Tooltip Text',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'.'))
                  ],
                  controller: tooltipTextController,
                  textInputType: TextInputType.text,
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
                          // ---------- Text Size ----------
                          TextFormWithLabel(
                            label: 'Text Size',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^\d+\.?\d*')), // Use regex to allow only numbers and a decimal point
                            ],
                            controller: textSizeController,
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
                          // ---------- Box Padding ----------
                          TextFormWithLabel(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^\d+\.?\d*')), // Use regex to allow only numbers and a decimal point
                            ],
                            label: 'Padding',
                            controller: paddingController,
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
                          // ---------- Corner Radius ----------
                          TextFormWithLabel(
                            label: 'Corner Radius',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^\d+\.?\d*')), // Use regex to allow only numbers and a decimal point
                            ],
                            controller: cornerRadiusController,
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
                          // ---------- Tooltip Width ----------
                          TextFormWithLabel(
                            label: 'Tooltip Width',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^\d+\.?\d*')), // Use regex to allow only numbers and a decimal point
                            ],
                            controller: tooltipWidthController,
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
                          // ---------- Arrow Width ----------
                          TextFormWithLabel(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^\d+\.?\d*')), // Use regex to allow only numbers and a decimal point
                            ],
                            label: 'Arrow Width',
                            controller: arrowWidthController,
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
                          // ---------- Arrow Height ----------
                          TextFormWithLabel(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^\d+\.?\d*')), // Use regex to allow only numbers and a decimal point
                            ],
                            label: 'Arrow Height',
                            controller: arrowHeightController,
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
                    // ---------- Text Color Selector ----------
                    ColorPicker(
                      label: 'Text Color',
                      initialColor: textColor,
                      onSelectColor: (value) {
                        // setState(() {
                        textColor = value;
                        // });
                      },
                    ),
                    // ---------- Background Color Selector ----------
                    ColorPicker(
                      label: 'Background Color',
                      initialColor: backgroundColor,
                      onSelectColor: (value) {
                        // setState(() {
                        backgroundColor = value;
                        // });
                      },
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ---------- Position Selector ----------
                    FormFieldWithLabel(
                      label: 'Tooltip Position',
                      value: selectedTooltipPosition,
                      items: const [
                        'top',
                        'bottom',
                        'right',
                        'left',
                        'auto'
                      ], // fixed this
                      onChanged: (value) {
                        selectedTooltipPosition = value!;
                        tooltipPosition = TooltipPosition.values.firstWhere(
                            (e) => e.name == selectedTooltipPosition);
                      },
                      controller: tooltipPositionController,
                    ),
                    // ---------- Image Picker ----------
                    ImagePickerWidget(
                      onTap: (image) {
                        this.image = image;
                      },
                      aspectRatio: (value) {
                        aspectRatio = value;
                      },
                    )
                  ],
                ),

                // ---------- Add Tooltip Image Input Here ----------
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          backgroundColor: const Color(0xFF0B58D9),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (mounted) {
                              setProperties();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    tooltipProperties: properties,
                                  ),
                                ),
                              );
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
}
