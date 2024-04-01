import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class adminNoticeBoard extends StatefulWidget {

  @override
  State<adminNoticeBoard> createState() => _adminNoticeBoardState();
}

class _adminNoticeBoardState extends State<adminNoticeBoard> {
  @override

  TextEditingController text = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade400,
      body:
         Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.all(20.00),
                child: Container(
                  height: 220,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: text,
                    decoration: InputDecoration(
                      labelText: "Enter Message",
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 20, top: 20, right: 20, bottom: 10),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    print("Clicked");
                    var url = Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Notice_Board/insert.php");
                    http.post(
                      url,
                      body: {
                        "text": text.text.toString(),
                      },
                    );
                    text.text = "";
                    print("Data sent successfully");
                  });
                },
                child: Text("Send", style: TextStyle(color: Colors.brown),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white),
              ),
            ],
          ),
        ),
      );

  }
}