import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  var isPost = true;
  String dropdownValue = 'Nepal';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              // allow multiline
              maxLines: null,
              //enable multiline keyboard
              // keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                // Move the focus to the next node explicitly.
                FocusScope.of(context).nextFocus();
              },
              maxLength: 100,
              decoration: InputDecoration(
                labelText: isPost ? 'CAPTION' : 'TITLE',
                labelStyle: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
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
                ? TextFormField(
                    maxLines: 15,
                    //enable multiline keyboard
                    // keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      // Move the focus to the next node explicitly.
                      FocusScope.of(context).nextFocus();
                    },
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
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  height: 200,
                  width: MediaQuery.of(context).size.width / 2.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: IconButton(
                    onPressed: () {
                      print('camera');
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
                    onPressed: () {
                      print('gallery');
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
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Post')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
