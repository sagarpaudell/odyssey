import 'package:flutter/material.dart';

class Explore extends StatefulWidget {

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<bool> isSelected=[true,false,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          
          
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
                  child: Text("POSTS", style: 
                  TextStyle(fontSize: 16),
                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("BLOGS",style: 
                  TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("PLACES",style: 
                  TextStyle(fontSize: 16),),
                ),
                
                
              ],
              onPressed: (int newIndex){
                setState(() {
                                for(int index=0;index<isSelected.length;index++){
                                  if(index==newIndex){
                                    isSelected[index]=true;
                                  }
                                  else{
                                    isSelected[index]=false;
                                  }
                                }
                              });
              },
            ),
          ),
        )
      ),
    );
}
}