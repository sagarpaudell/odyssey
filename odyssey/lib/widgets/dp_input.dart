import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DpInput extends StatefulWidget {
  Function onSelectImg;

  DpInput(this.onSelectImg);
  @override
  _DpInputState createState() => _DpInputState();
}

class _DpInputState extends State<DpInput> {
  File _storedImage;
  String profilePicUrl;

  // Future<void> _takePicture() async {
  //   final imageFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 600,
  //   );
  //   if (imageFile == null) {
  //     return;
  //   }

  //   setState(() {
  //     _storedImage = imageFile;
  //   });
  //   // await Provider.of<Profile>(context, listen: false)
  //   //     .tempProfile(_storedImage);
  //   // final appDir = await syspaths.getApplicationDocumentsDirectory();
  //   // final fileName = path.basename(imageFile.path);
  //   // final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
  //   widget.onSelectImg(_storedImage);
  // }

  Future<void> _pickImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    final selection = File(selected.path);

    setState(() {
      _storedImage = selection;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _storedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
        // cropGridRowCount: 2,
        showCropGrid: true,
        // cropGridColumnCount: 10,
      ),
    );

    setState(() {
      _storedImage = cropped;
    });

    widget.onSelectImg(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    profilePicUrl =
        Provider.of<Auth>(context, listen: false).userProfileInfo['photo_main'];
    Size deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      height: deviceSize.width * 0.3,
      width: deviceSize.width * 0.3,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: _storedImage != null
                ? FileImage(
                    File(_storedImage.path),
                  )
                : NetworkImage(profilePicUrl),
            child: profilePicUrl == null
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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  await _pickImage(ImageSource.camera);
                                  // print(_placeImageFile);
                                  Navigator.pop(context);
                                  await _cropImage();
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.camera,
                                  color: Colors.indigo,
                                  size: 35,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await _pickImage(ImageSource.gallery);
                                  await _cropImage();
                                },
                                icon: Icon(
                                  Icons.photo,
                                  color: Colors.teal,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
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
