import 'package:flutter/material.dart';
import 'package:odyssey/data/data.dart';
import '../providers/posts.dart';
import '../providers/search.dart';
import '../providers/place.dart';
import './place_screen.dart';
import '../providers/blog.dart' as blogss;
import 'package:provider/provider.dart';
import '../widgets/fb_loading.dart';
import '../widgets/post_container.dart';
import '../widgets/place_container.dart';
import './profile_user.dart';
import '../widgets/blog_container.dart';
import '../widgets/empty.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<bool> isSelected = [true, false, false];
  var _searchController = TextEditingController();
  bool _isSearch = false;
  List<dynamic> searchResults = [];
  bool _isLoading = false;
  List<dynamic> explorePosts;
  List<dynamic> exploreBlogs;
  List<dynamic> explorePlace;

  Future fbuilder;
  @override
  void initState() {
    fbuilder = getBPosts();
    super.initState();
  }

  Future<void> getBPosts() async {
    var temp = await Provider.of<Posts>(context, listen: false).getPosts(true);
    setState(() {
      explorePosts = temp;
    });
  }

  Future<void> getexploreBlogs() async {
    List<dynamic> tempblogs =
        await Provider.of<blogss.Blog>(context, listen: false)
            .getAllBlogs(true);
    setState(() {
      exploreBlogs = tempblogs;
    });
  }

//
//  widget.id != null? FutureBuilder<void>(
//     future: getSinglePlaceFun(), // a previously-obtained Future<String> or null
//     builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
//         snapshot.connectionState == ConnectionState.waiting
//             ? SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     return Center(child: CircularProgressIndicator(),);
//                   },
  Future<void> explorePlaces() async {
    List<dynamic> placesList =
        await Provider.of<Place>(context, listen: false).getAllPlaces();
    setState(() {
      explorePlace = placesList;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected[1]) {
      getexploreBlogs();
    }
    if (isSelected[2]) {
      explorePlaces();
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                      borderRadius: BorderRadius.circular(20),
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "PLACES",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                      onPressed: (int newIndex) {
                        searchResults = [];
                        _searchController.text = '';
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    onTap: () => setState(() {
                      _isSearch = !_isSearch;
                    }),
                    controller: _searchController,
                    onChanged: (_) async {
                      if (_searchController.text.length > 1) {
                        setState(() {
                          _isLoading = true;
                        });
                        searchResults =
                            await Provider.of<Search>(context, listen: false)
                                .search(_searchController.text, isSelected[2]);
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    onSubmitted: (_) => setState(() {
                      _searchController.text = '';
                      _isSearch = !_isSearch;
                    }),
                    decoration: InputDecoration(
                        hintText: isSelected[2] == true
                            ? "Search by Places"
                            : "Search by People",
                        filled: true,
                        fillColor: Color(0xffF5F5F5),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        )),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          !_isSearch
              ? isSelected[0] == true
                  ? PostContent(fbuilder, explorePosts)
                  : isSelected[1] == true
                      ? BlogContent(exploreBlogs)
                      : PlaceContent(explorePlace)
              : _searchController.text.length > 1
                  ? SearchContext(_isLoading, searchResults, isSelected[2])
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Center(
                            child: Text(
                              'Search awesome people and places',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
        ],
      ),
    );
  }
}

Widget PostContent(Future fbuilder, List<dynamic> explorePosts) {
  return FutureBuilder<void>(
    future: fbuilder, // a previously-obtained Future<String> or null
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
            : explorePosts.isEmpty
                  ? emptySliver(false)
                  :SliverList(
                delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PostContainer(post: explorePosts[index]);
                },
                childCount: explorePosts.length,
              )),
  );
}

Widget BlogContent(List<dynamic> exploreBlogs) {
  return exploreBlogs == null
      ? SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return FbLoading();
            },
            childCount: 1,
          ),
        )
      :exploreBlogs.isEmpty
                  ? emptySliver(false)
                  :SliverList(
          delegate: SliverChildBuilderDelegate(
          (context, index) {
            return BlogContainer(exploreBlogs[index]);
          },
          childCount: exploreBlogs.length,
        ));
}

Widget SearchContext(
    bool _isLoading, List<dynamic> searchResults, bool searchPlace) {
  return _isLoading
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
      : searchResults.isEmpty
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Center(
                    child: Text(
                      ' Oops! No result found',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  );
                },
                childCount: 1,
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: searchPlace
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => PlaceScreen(null,
                                                  searchResults[index]['id'])),
                                        );
                                      },
                                      child: Text(
                                        searchResults[index]['name'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UserProfile(
                                              searchResults[index]['username']),
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            radius: 20.0,
                                            backgroundColor: Colors.grey[200],
                                            backgroundImage: NetworkImage(
                                                searchResults[index]
                                                    ['photo_main']),
                                            onBackgroundImageError:
                                                (Object exception,
                                                    StackTrace stackTrace) {
                                              return Image.asset(
                                                  './assets/images/guptaji.jpg');
                                            }),
                                        title: Text(
                                          '${searchResults[index]['first_name']} ${searchResults[index]['last_name']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                            '@ ${searchResults[index]['username']}'),
                                      ),
                                    )),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              );
            }, childCount: searchResults.length));
}

Widget PlaceContent(List<dynamic> explorePlace) {
  return explorePlace == null
      ? SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return FbLoading();
            },
            childCount: 1,
          ),
        )
      :explorePlace.isEmpty
                  ? emptySliver(false)
                  : SliverList(
          delegate: SliverChildBuilderDelegate(
          (context, index) {
            return PlaceContainer(explorePlace[index]);
          },
          childCount: explorePlace.length,
        ));
}
