import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File) imagePicked;
  const UserImagePicker(this.imagePicked, {Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });

      widget.imagePicked(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage!) : null,
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add image'),
          ),
        ],
      ),
    );
  }
}
