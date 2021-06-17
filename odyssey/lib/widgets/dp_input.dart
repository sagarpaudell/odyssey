import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class DpInput extends StatefulWidget {
  Function onSelectImg;

  DpInput(this.onSelectImg);
  @override
  _DpInputState createState() => _DpInputState();
}

class _DpInputState extends State<DpInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImg(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: _storedImage != null
                ? Image.file(
                    _storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Text(
                    'No Image Taken',
                    textAlign: TextAlign.center,
                  ),
            alignment: Alignment.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.camera),
          onPressed: _takePicture,
        ),
      ],
    );
  }
}
