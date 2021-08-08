import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../screens/place_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
// import '../screens/single_Place_screen.dart';
// import '../providers/Place.dart';

class PlaceContainer extends StatefulWidget {
  final Map<String, dynamic> singlePlace;

  const PlaceContainer(this.singlePlace);

  @override
  _PlaceContainerState createState() => _PlaceContainerState();
}

class _PlaceContainerState extends State<PlaceContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hi');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaceScreen(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(bottom: 10),
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 3,
          ),
          // boxShadow: [BoxShadow(
          //   // blurRadius: ,

          // )],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              // Image(
              //   image: NetworkImage(widget.singlePlace["photo1"]),
              //   errorBuilder: (BuildContext context, Object exception,
              //       StackTrace stackTrace) {
              //     return Image.asset('./assets/images/mana.jpg');
              //   },
              //   height: 250,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),

              ImageSlideshow(
                width: double.infinity,
                height: 250,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _PlaceInfo(
                  widget.singlePlace,
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _PlaceInfo(
  Map<String, dynamic> singlePlace,
  BuildContext context,
) {
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      Text(
        singlePlace['title'],
        style: TextStyle(
          fontFamily: 'Arial',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    ],

    // const Divider(),
  );
}
