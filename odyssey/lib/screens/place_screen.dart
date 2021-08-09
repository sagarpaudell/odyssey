import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:odyssey/providers/posts.dart';
import 'package:odyssey/widgets/fb_loading.dart';
import 'package:odyssey/widgets/post_container.dart';
import 'package:odyssey/widgets/blog_container.dart';
import '../providers/blog.dart';
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
  int placeId;
  List<dynamic> posts;
  List<dynamic> exploreBlog;
  List<dynamic> explorePlace;

  Future fbuilder;
  @override
  void initState() {
    fbuilder = getSinglePlaceFun();

    super.initState();
  }

  // Future<void> getexploreBlogs() async {
  //   List<dynamic> tempblogs =
  //       await Provider.of<blogss.Blog>(context, listen: false)
  //           .getAllBlogs(true);
  //   setState(() {
  //     exploreBlogs = tempblogs;
  //   });
  // }

  Map<String, dynamic> singlePlace;
  List<bool> isSelected = [true, false, false];
  Future<void> getSinglePlaceFun() async {
    if (widget._singlePlace != null) {
      singlePlace = widget._singlePlace;
      placeId = singlePlace['id'];

      return;
    } else {
      placeId = widget.id;
    }
    singlePlace =
        await Provider.of<Place>(context, listen: false).getSinglePlace(
      widget.id.toString(),
    );
    print('getting single place $singlePlace');
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
                  alignment: Alignment.centerLeft,
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
                            "POSTS",
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
          isSelected[0] == true
              ? FutureBuilder<void>(
                  future:
                      getSinglePlaceFun(), // a previously-obtained Future<String> or null
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return FbLoading();
                                    },
                                    childCount: 1,
                                  ),
                                )
                              : InfoContent(singlePlace))
              : isSelected[1] == true
                  ? PostContent(placeId)
                  : BlogContent(placeId)
        ],
      ),
    );
  }

  returnKeywords(singlePlace) {
    var keywordList = singlePlace['keywords'].split(" ");
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: <Widget>[
          for (var key in keywordList)
            Text(
              '#' + '$key' + ' ',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.normal,
              ),
            )
        ],
      ),
    );
  }

  Widget InfoContent(Map<String, dynamic> singlePlace) {
    return SliverList(
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
                  singlePlace["photo_1"] != null
                      ? Image(
                          image: NetworkImage(
                            singlePlace["photo_1"],
                          ),
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image.asset('./assets/images/mana.jpg');
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
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image.asset('./assets/images/mana.jpg');
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
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image.asset('./assets/images/mana.jpg');
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
              Divider(
                thickness: 0.9,
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
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
                    Divider(
                        thickness: 0.9,
                        height: 10,
                        endIndent: MediaQuery.of(context).size.width * 0.1),

                    Wrap(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Keywords:',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              height: 1.5,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        returnKeywords(singlePlace),
                      ],
                    ),
                    Divider(
                        thickness: 0.9,
                        height: 10,
                        endIndent: MediaQuery.of(context).size.width * 0.1),

                    // SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Place description:',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          height: 1.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        singlePlace['description'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.normal,
                        ),
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
    );
  }

  Widget PostContent(int placeId) {
    List<dynamic> posts;
    Future<void> getPostByPlace() async {
      posts = await Provider.of<Posts>(context, listen: false)
          .getPostsByPlace(placeId.toString());
      print('this is $posts');
      //posts = await Provider.of<Posts>(context, listen: false).getPosts(true);
    }

    return FutureBuilder<void>(
      future: getPostByPlace(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FbLoading();
                    },
                    childCount: 1,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PostContainer(post: posts[index]);
                  },
                  childCount: posts.length,
                )),
    );
  }

  Widget BlogContent(int placeId) {
    List<dynamic> blogs;
    Future<void> getBlogByPlace() async {
      blogs = await Provider.of<Blog>(context, listen: false)
          .getBlogsByPlace(placeId.toString());
    }

    return FutureBuilder<void>(
      future: getBlogByPlace(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FbLoading();
                    },
                    childCount: 1,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return BlogContainer(blogs[index]);
                    },
                    childCount: blogs.length,
                  ),
                ),
    );
  }
}
