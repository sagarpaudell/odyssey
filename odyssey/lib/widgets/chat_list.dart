import 'package:flutter/material.dart';
import 'package:odyssey/widgets/message.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 2,
        itemBuilder: (BuildContext context, int nothing) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Message(),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage:
                                AssetImage('./assets/images/guptaji.jpg'),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 14,
                              width: 14,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent[400],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                            ),
                          )
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deependra Gupta',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 6),
                              Opacity(
                                opacity: 0.9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: deviceSize.width * 0.45,
                                      child: Text(
                                        'K gardai ho bro? Sanchai chau?',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 0),
                                      width: deviceSize.width * 0.18,
                                      child: Text('3 hrs ago',
                                          //11:49 a.m

                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 80,
                  ),
                  child: Opacity(
                    opacity: 0.4,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
