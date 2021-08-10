import 'package:flutter/material.dart';

Widget emptySliver(bool feeds) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return  Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.25),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height:MediaQuery.of(context).size.height*0.2,
                    child: Image.asset('./assets/images/box.png')
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Oops! such empty',
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
                  ),
                  feeds==true?
                  OutlinedButton(onPressed:(){},
                  child:Text('Follow users to update your feed',
                style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
              ),
                  ):SizedBox(

                  )
                  
                ],
              ),
            
        );
      },
      childCount: 1,
    ),
  );
}
