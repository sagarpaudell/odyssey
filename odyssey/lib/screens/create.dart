import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:odyssey/providers/posts.dart';
import 'package:odyssey/providers/profile.dart';
import 'package:provider/provider.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  File _imageFile;
  bool showImage = false;
  var isPost = true;
  String caption;
  String dropdownValue = 'Nepal';
  final _captionController = TextEditingController();
  Future<void> _pickImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    final selection = File(selected.path);

    setState(() {
      _imageFile = selection;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
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
      _imageFile = cropped;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
      showImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
        child: Column(
          children: [
            TextField(
              // allow multiline
              maxLines: null,
              //enable multiline keyboard
              // keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   // Move the focus to the next node explicitly.
              //   FocusScope.of(context).nextFocus();
              //   setState((e) {
              //     caption = e.text;
              //   });

              // },
              controller: _captionController,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: isPost ? 'CAPTION' : 'TITLE',
                labelStyle: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                // hintText: 'Write something about your post . . .',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 58,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isPost = true;
                      });
                    },
                    child: isPost
                        ? Text(
                            'POST',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(28, 46, 74, 1),
                            ),
                          )
                        : Text(
                            'POST',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isPost = false;
                    });
                  },
                  child: isPost
                      ? Text(
                          'BLOG',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : Text(
                          'BLOG',
                          style: TextStyle(
                            color: Color.fromRGBO(28, 46, 74, 1),
                            fontSize: 16,
                          ),
                        ),
                )
              ],
            ),
            !isPost
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(),
            !isPost
                ? TextField(
                    maxLines: 15,
                    //enable multiline keyboard
                    // keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (_) {
                    //   // Move the focus to the next node explicitly.
                    //   FocusScope.of(context).nextFocus();
                    // },
                    maxLength: 2000,
                    decoration: InputDecoration(
                      labelText: 'DESCRITPION',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      // hintText: 'Write something about your post . . .',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  )
                : SizedBox(),
            isPost
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Text(
                  'PLACE',
                  style: TextStyle(letterSpacing: 1.5),
                ),
                SizedBox(
                  width: 30,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Nepal', 'Kathmandu', 'Pokhara', 'Bhaktapur']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [Icon(Icons.photo_album), Text('GALLERY')],
            ),
            Row(
              children: [
                showImage
                    ? Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(_imageFile),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    color: Colors.white.withOpacity(0.8),
                                    iconSize: 20,
                                    onPressed: () {
                                      _clear();
                                    },
                                    // icon:Icons.close,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                        // height: 200,
                        width: 200,
                      )
                    : Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                            height: 200,
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: IconButton(
                              onPressed: () async {
                                await _pickImage(ImageSource.camera);
                                print(_imageFile);
                                await _cropImage();
                                setState(() {
                                  showImage = true;
                                });
                              },
                              icon: Icon(
                                Icons.camera,
                                color: Colors.indigo,
                                size: 35,
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: IconButton(
                              onPressed: () async {
                                await _pickImage(ImageSource.gallery);
                                await print('imagefile:${_imageFile}');
                                await _cropImage();
                                setState(() {
                                  showImage = true;
                                });
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
              ],
            ),
            Row(
              children: [
                isPost
                    // Publish Post
                    ? ElevatedButton(
                        onPressed: () {
                          print('caption: ${_captionController.text}');
                          Provider.of<Posts>(context, listen: false)
                              .publishPost(_captionController.text, _imageFile);
                        },
                        child: Text('Publish'),
                      )
                    // Publish Blog
                    : ElevatedButton(onPressed: () {}, child: Text('Publish')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
