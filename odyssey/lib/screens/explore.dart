import 'package:flutter/material.dart';
import '../providers/posts.dart';
import '../providers/search.dart';

import '../providers/blog.dart' as blogss;
import 'package:provider/provider.dart';
import '../widgets/fb_loading.dart';
import '../widgets/post_container.dart';
import '../widgets/place_container.dart';

import '../widgets/blog_container.dart';

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
  List<dynamic> explorePlace = [
    {
      'title': 'Langtang',
      'photo1':
          'https://images.unsplash.com/photo-1513614835783-51537729c8ba?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
    },
    {
      'title': 'Dhulikhel',
      'photo1':
          'https://images.unsplash.com/photo-1628128502571-d890a5974f61?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
    },
  ];

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
                      if (_searchController.text.length > 2) {
                        setState(() {
                          _isLoading = true;
                        });
                        searchResults =
                            await Provider.of<Search>(context, listen: false)
                                .search(_searchController.text);
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
              : SearchContext(_isLoading, searchResults)
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
            : SliverList(
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
      : SliverList(
          delegate: SliverChildBuilderDelegate(
          (context, index) {
            return BlogContainer(exploreBlogs[index]);
          },
          childCount: exploreBlogs.length,
        ));
}

Widget SearchContext(bool _isLoading, List<dynamic> searchResults) {
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
      : SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,),
            child: ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.search, color: Colors.grey[400],),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(searchResults.isEmpty
                            ? 'Sorry, No results found'
                            : searchResults[index]['name'],
                            style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w500),),
                      ),
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
      : SliverList(
          delegate: SliverChildBuilderDelegate(
          (context, index) {
            return PlaceContainer(explorePlace[index]);
          },
          childCount: explorePlace.length,
        ));
}
