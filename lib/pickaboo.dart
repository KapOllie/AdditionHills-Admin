import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Pickaboo extends StatefulWidget {
  const Pickaboo({super.key});

  @override
  State<Pickaboo> createState() => _PickabooState();
}

class _PickabooState extends State<Pickaboo> {
  PlatformFile? _imageFile;
  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result == null) {
        return;
      }
      setState(() {
        _imageFile = result.files.first;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Image Picker'),
            if (_imageFile != null)
              Image.memory(
                Uint8List.fromList(_imageFile!.bytes!),
                width: 400,
                height: 600,
              ),
            Container(
              height: 50,
              width: 50,
              child: ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text('Pick an image')),
            )
          ],
        ),
      ),
    );
  }
}
