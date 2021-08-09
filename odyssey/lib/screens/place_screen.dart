import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class PlaceScreen extends StatefulWidget {
  final Map<String, dynamic> singlePlace;

  const PlaceScreen(this.singlePlace);
  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Theme.of(context).primaryColor,
      //     ),
      //     onPressed: () => Navigator.pop(context, false),
      //   ),
      //   backgroundColor: Colors.white,
      //   title: Row(
      //     children: [
      //       Text(
      //         'Place Name',
      //         style: TextStyle(
      //           fontWeight: FontWeight.w600,
      //           color: Theme.of(context).primaryColor,
      //         ),
      //       ),
      //     ],
      //   ),
      //   centerTitle: true,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            floating: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: ToggleButtons(
                        fillColor: Theme.of(context).primaryColor,
                        selectedColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        highlightColor: Colors.blueGrey,
                        isSelected: isSelected,
                        renderBorder: false,
                        borderRadius: BorderRadius.circular(10),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "INFO",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "BLOGS",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "POSTS",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int index = 0;
                                index < isSelected.length;
                                index++) {
                              if (index == newIndex) {
                                isSelected[index] = true;
                              } else {
                                isSelected[index] = false;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ImageSlideshow(
                      width: double.infinity,
                      height: 300,
                      initialPage: 0,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorBackgroundColor: Colors.grey[600],
                      autoPlayInterval: 0,
                      isLoop: true,
                      children: [
                        widget.singlePlace["photo_1"] != null
                            ? Image(
                                image: NetworkImage(
                                  widget.singlePlace["photo_1"],
                                ),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                      './assets/images/mana.jpg');
                                },
                              )
                            : Center(
                                child: Text(
                                'Photo Unavailable',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        widget.singlePlace["photo_2"] != null
                            ? Image(
                                image: NetworkImage(
                                  widget.singlePlace["photo_2"],
                                ),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                      './assets/images/mana.jpg');
                                },
                              )
                            : SizedBox(
                                height: 0,
                                width: 0,
                              ),
                        widget.singlePlace["photo_3"] != null
                            ? Image(
                                image: NetworkImage(
                                  widget.singlePlace["photo_3"],
                                ),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                      './assets/images/mana.jpg');
                                },
                              )
                            : SizedBox(
                                height: 0,
                                width: 0,
                              ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          SizedBox(height: 6),
                          Row(children: [
                            Text(
                              widget.singlePlace['name'],
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 28,
                                height: 1.5,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                          SizedBox(height: 20),
                          Text(
                            widget.singlePlace['description'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              height: 1.5,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
