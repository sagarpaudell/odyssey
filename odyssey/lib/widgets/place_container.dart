import 'package:flutter/material.dart';
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
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 3,
          ),
          // boxShadow: [BoxShadow(
          //   // blurRadius: ,

          // )],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.singlePlace["photo1"]),
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image.asset('./assets/images/mana.jpg');
              },
              fit: BoxFit.cover,
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
            letterSpacing: 0.8),
      ),
    ],

    // const Divider(),
  );
}
