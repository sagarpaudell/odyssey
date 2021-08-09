import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:odyssey/providers/posts.dart';
import 'package:odyssey/providers/profile.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  File _imageFile;
  File _placeImageFile;
  bool isSwitched = false;
  bool showImage = false;
  bool showPlaceImage = false;
  var isPost = true;
  String caption;
  String dropdownValue = 'Nepal';
  List tags = [];
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  final _placeNameController = TextEditingController();
  final _placeDescController = TextEditingController();
  final _captionController = TextEditingController();
  Future<void> _pickImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    final selection = File(selected.path);

    setState(() {
      _imageFile = selection;
    });
  }

  Future<void> _pickPlaceImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    final selection = File(selected.path);

    setState(() {
      _placeImageFile = selection;
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

  Future<void> _cropPlaceImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _placeImageFile.path,
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
      _placeImageFile = cropped;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
      showImage = false;
    });
  }

  void _clearPlaceImage() {
    setState(() {
      _placeImageFile = null;
      showPlaceImage = false;
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
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Text(
                  'CREATE A NEW PLACE',
                  style: TextStyle(letterSpacing: 1.3),
                ),
                SizedBox(
                  width: 5,
                ),
                Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeColor: Theme.of(context).primaryColor,
                  // activeTrackColor: Colors.yellow,
                  inactiveThumbColor: Colors.grey[300],
                  inactiveTrackColor: Colors.grey[350],
                )
              ],
            ),
            isPost
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(),
            !isSwitched
                ? Row(
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
                        items: <String>[
                          'Nepal',
                          'Kathmandu',
                          'Pokhara',
                          'Bhaktapur'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      TextField(
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                        controller: _placeNameController,
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: 'NAME OF THE PLACE',
                          labelStyle: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      TextField(
                        maxLines: 5,
                        textInputAction: TextInputAction.next,
                        controller: _placeDescController,
                        maxLength: 2000,
                        decoration: InputDecoration(
                          labelText: 'DESCRITPION OF THE PLACE',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFieldTags(
                          initialTags: <String>[
                            // List of tags
                            // Provide a list of initial tags to initialize it
                          ],
                          textFieldStyler: TextFieldStyler(
                            //These are properties you can tweek for customization

                            textFieldFilled: true,
                            // Icon icon,
                            // String helperText = 'Enter tags',
                            helperStyle: TextStyle(
                              // letterSpacing: 1.5,
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                            hintText: 'FOR EG: Mountain, Nature',
                            hintStyle: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            // EdgeInsets contentPadding,
                            textFieldFilledColor: Colors.grey[100],
                            isDense: false,
                            textFieldEnabled: true,
                            textFieldBorder: InputBorder.none,
                            textFieldFocusedBorder: InputBorder.none,
                            textFieldDisabledBorder: InputBorder.none,
                            textFieldEnabledBorder: InputBorder.none,
                          ),
                          tagsStyler: TagsStyler(
                            //These are properties you can tweek for customization

                            showHashtag: true,
                            // EdgeInsets tagPadding = const EdgeInsets.all(4.0),
                            // EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
                            tagDecoration:
                                BoxDecoration(color: Colors.grey[200]),
                            // TextStyle tagTextStyle,
                            tagCancelIcon: Icon(Icons.cancel,
                                size: 18.0, color: Colors.red[400]),
                          ),
                          onTag: (tag) {
                            //This give you the tag that was entered
                            tags.add(tag);
                            print(tags);
                          },
                          onDelete: (tag) {
                            //This gives you the tag that was deleted
                            //print(tag)
                          },
                          validator: (tag) {
                            if (tag.length > 15) {
                              return "Max Length: 15";
                            }
                            return null;
                          }
                          //tagsDistanceFromBorderEnd: 0.725,
                          //scrollableTagsMargin: EdgeInsets.only(left: 9),
                          //scrollableTagsPadding: EdgeInsets.only(left: 9),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.photo_album),
                          Text('PHOTO OF THE PLACE'),
                        ],
                      ),
                      Row(
                        children: [
                          showPlaceImage
                              ? Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Image.file(_placeImageFile),
                                          Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              // color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.close),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              iconSize: 20,
                                              onPressed: () {
                                                _clearPlaceImage();
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
                                      margin:
                                          EdgeInsets.fromLTRB(0, 20, 20, 20),
                                      height: 200,
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await _pickPlaceImage(
                                              ImageSource.camera);
                                          print(_placeImageFile);
                                          await _cropPlaceImage();
                                          setState(() {
                                            showPlaceImage = true;
                                            print(
                                              'showPlaceImage: $showPlaceImage',
                                            );
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
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await _pickPlaceImage(
                                              ImageSource.gallery);
                                          await _cropPlaceImage();
                                          setState(() {
                                            showPlaceImage = true;
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
                              .publishPost(
                            _captionController.text,
                            _imageFile,
                            '1',
                            _placeImageFile,
                            _placeNameController.text,
                            _placeDescController.text,
                            tags,
                            isSwitched,
                          );
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
