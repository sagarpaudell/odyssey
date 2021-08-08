import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class PlaceScreen extends StatefulWidget {
  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  List<bool> isSelected = [true, false, false];

  Future fbuilder;
  Map<String, dynamic> singleBlogData;
  @override
  void initState() {
    // fbuilder = getUserPosts();
    super.initState();
  }

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
                        Image.network(
                          'https://source.unsplash.com/random/300x300',
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          'https://source.unsplash.com/random/300x300',
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          'https://source.unsplash.com/random/300x300',
                          fit: BoxFit.cover,
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
                              'Place Name',
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
                            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi ab error provident dignissimos vel eligendi doloribus harum, natus esse beatae! Est quae velit labore voluptatum adipisci, quos vero dicta necessitatibus. Optio eos perferendis maxime aut hic, voluptatem sed accusantium harum impedit voluptates porro dolor magni labore nam ipsa inventore distinctio deserunt quasi similique, eveniet iure aspernatur. Possimus, odit nostrum? Inventore nemo saepe, est eum ipsa quae necessitatibus tenetur, ex, ad hic voluptatibus laborum laboriosam qui dolorem exercitationem magnam itaque id veritatis dolor illum minima ipsum delectus. Tempore doloribus laudantium modi explicabo provident non quas soluta officia fuga molestiae, quae minus doloremque id ipsa rerum ducimus omnis reprehenderit voluptates vel. Incidunt illum aspernatur deserunt? Minima, omnis at dolore ipsum totam repudiandae velit tempore tenetur dolor architecto illo dolorum, facilis nostrum nam. Sapiente amet mollitia impedit nulla qui aliquam dolores error ad voluptate corporis itaque sunt in facilis optio at sequi, alias nesciunt iste deleniti sed? Libero laudantium omnis sit, error quo hic delectus accusantium enim voluptatum natus, dolor sint pariatur aspernatur laboriosam corporis. Magnam nisi, aliquid, minima sapiente beatae voluptatum consequuntur consequatur quae eligendi qui similique? Error adipisci, est optio cumque eius dignissimos quo pariatur temporibus nisi fugiat assumenda neque, voluptates inventore libero dolorum tenetur magni totam. Doloribus aspernatur libero vel consectetur tempore quia odio ipsa! Porro adipisci deserunt suscipit quibusdam nemo sed, officia vero eligendi labore earum qui ratione impedit dolore amet maxime totam asperiores! Non voluptas atque quibusdam dolorem, cupiditate repellat aut, quaerat ipsa blanditiis iste laudantium nulla? Illo ea accusamus autem architecto ad, unde illum, est tempore dolore numquam fugit omnis, sequi porro deleniti corrupti necessitatibus inventore natus maiores? Quaerat sint, esse tempora cumque maiores obcaecati a expedita illum, magni tenetur pariatur dolores. Sed soluta quasi deleniti. Ipsa at ratione laudantium quibusdam doloremque ipsum, asperiores officiis sequi nemo.',
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
