import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_svg/flutter_svg.dart';

class DpInput extends StatefulWidget {
  Function onSelectImg;

  DpInput(this.onSelectImg);
  @override
  _DpInputState createState() => _DpInputState();
}

class _DpInputState extends State<DpInput> {
  PickedFile _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = imageFile;
    });
    // await Provider.of<Profile>(context, listen: false)
    //     .tempProfile(_storedImage);
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImg(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      height: deviceSize.width * 0.45,
      width: deviceSize.width * 0.45,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: _storedImage != null
                ? FileImage(
                    File(_storedImage.path),
                  )
                : null,
            child: _storedImage == null
                ? SvgPicture.asset("assets/icons/man.svg")
                : null,
          ),
          Positioned(
            right: 7,
            bottom: 0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFF5F6F9)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),

                  //RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(50),
                  //   side: BorderSide(color: Colors.white),
                ),
                onPressed: _takePicture,
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.camera),
          //   onPressed: _takePicture,
          // ),
        ],
      ),
    );
  }
}
