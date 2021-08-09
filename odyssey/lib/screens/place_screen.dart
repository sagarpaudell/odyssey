import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import '../providers/place.dart';

class PlaceScreen extends StatefulWidget {
  final Map<String, dynamic> _singlePlace;
  final int id;
  const PlaceScreen([this._singlePlace, this.id]);
  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  Map<String, dynamic> singlePlace;
  List<bool> isSelected = [true, false, false];
  Future<void> getSinglePlaceFun() async {
    if (widget._singlePlace != null) {
      singlePlace = widget._singlePlace;
      return;
    }
    singlePlace =
        await Provider.of<Place>(context, listen: false).getSinglePlace(
      widget.id.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (widget._singlePlace != null) {
    //   singlePlace = widget._singlePlace;
    // }
    return Scaffold(
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
            title: Column(
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
            centerTitle: true,
          ),
          FutureBuilder<void>(
            future: getSinglePlaceFun(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          childCount: 1,
                        ),
                      )
                    : SliverList(
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
                                  indicatorColor:
                                      Theme.of(context).primaryColor,
                                  indicatorBackgroundColor: Colors.grey[600],
                                  autoPlayInterval: 0,
                                  isLoop: true,
                                  children: [
                                    singlePlace["photo_1"] != null
                                        ? Image(
                                            image: NetworkImage(
                                              singlePlace["photo_1"],
                                            ),
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
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
                                    singlePlace["photo_2"] != null
                                        ? Image(
                                            image: NetworkImage(
                                              singlePlace["photo_2"],
                                            ),
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
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
                                            ),
                                          ),
                                    singlePlace["photo_3"] != null
                                        ? Image(
                                            image: NetworkImage(
                                              singlePlace["photo_3"],
                                            ),
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
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
                                            ),
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
                                          singlePlace['name'],
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
                                        singlePlace['description'],
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
                      ),
          )
        ],
      ),
    );
  }
}
