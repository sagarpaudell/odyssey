import 'package:flutter/material.dart';

class FbLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Image(image: AssetImage('./assets/images/fb_loading.gif')),
        SizedBox(
          height: 20,
        ),
        Image(image: AssetImage('./assets/images/fb_loading.gif')),
        SizedBox(
          height: 20,
        ),
        Image(image: AssetImage('./assets/images/fb_loading.gif')),
        SizedBox(
          height: 20,
        ),
        Image(image: AssetImage('./assets/images/fb_loading.gif')),
        SizedBox(
          height: 20,
        ),
        Image(image: AssetImage('./assets/images/fb_loading.gif')),
        SizedBox(
          height: 20,
        ),
        Image(image: AssetImage('./assets/images/fb_loading.gif')),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
