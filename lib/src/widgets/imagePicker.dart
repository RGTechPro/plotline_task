import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ImagePickerWidget extends StatefulWidget {
  final ValueSetter<Uint8List?> onTap;
  final ValueSetter<double> aspectRatio;
  const ImagePickerWidget({super.key, required this.onTap, required this.aspectRatio});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? image;
  Uint8List? byteImage;
  String? fileName;
  double? aspectRatio;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Select image',
              style:
                  kFormLabelTextStyle, // You should define kFormLabelTextStyle
            ),
          ),
          GestureDetector(
            onTap: () async {
              await pickImage();
              widget.onTap(byteImage!);
              widget.aspectRatio(aspectRatio!);
            },
            child: Container(
              height: 45,
              width: 180,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffD9D9D9)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: (fileName != null)
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Flexible(child: Icon(Icons.image)),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Text(
                                fileName!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Flexible(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      fileName = null;
                                      image = null;
                                      widget.onTap(null);
                                    });
                                  },
                                  icon: const Icon(Icons.close)))
                        ],
                      ),
                    )
                  : const Icon(Icons.image),
            ),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() {
        this.image = imageTemp;
        fileName = imageTemp.name;
        byteImage = Uint8List.fromList(File(image.path).readAsBytesSync());
      });
      var decodedImage = await decodeImageFromList(byteImage!);

      aspectRatio = decodedImage.width / decodedImage.height;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
