import 'package:flutter/material.dart';
class visitors extends StatefulWidget {
  @override
  visitorsState createState() => visitorsState();
}

class visitorsState extends State<visitors> {
  late List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Visitors",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade300,
      body:

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("If any of your Guest will come, \n You will get a call \n"
                    " Accept the call \n then only Guest can come.",
                  style: TextStyle(color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ), // Add shadow for a more appealing look
                      ],
                      fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            ),
          ),


    );
  }
}