import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class adminVisitors extends StatefulWidget {
  @override
  adminVisitorsState createState() => adminVisitorsState();
}

class adminVisitorsState extends State<adminVisitors> {
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
      backgroundColor: Colors.brown.shade400,
      body:
          Center(
            child: FutureBuilder<List>(
              future: getdetail(),
              builder: (ctx, ss) {
                if (ss.hasData) {
                  return Items(
                    list: ss.data!,
                    makePhoneCall: _makePhoneCall,
                  );
                }
                if (ss.hasError) {
                  print('Network Not Found');
                }

                return CircularProgressIndicator();
              },
            ),
          ),
    );
  }

  Future<List> getdetail() async {
    var response = await http.get(Uri.parse(
        "https://aesha2002.000webhostapp.com/Digital_Society/Login_Register/register_view.php"));
    return jsonDecode(response.body);
  }

  void _makePhoneCall(String phoneNumber) async {
    String telScheme = 'tel:$phoneNumber';
    if (await canLaunch(telScheme)) {
      await launch(telScheme);
    } else {
      throw 'Could not launch $telScheme';
    }
  }

}

class Items extends StatelessWidget {
  final List list;
  final Function(String) makePhoneCall;

  Items({required this.list, required this.makePhoneCall});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          height: 135,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2), // changes the position of the shadow
              ),
            ],
          ),
          child: ListTile(
            title: Row(
              children: [
                Text(
                  "${list[i]['firstname']} ${list[i]['lastname']}",
                  style: TextStyle(
                      color: Colors.brown, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("phone: ${list[i]['phone']}",
                          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                      Text("Address(Wing): ${list[i]['address']}",
                          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                      Text("email: ${list[i]['email']}",
                          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: ()
                  {
                    final phone = list[i]['phone']?.toString() ?? ''; // Use 'MobileNo' instead of 'MobileNumber'
                    print('Item data: ${list[i]}');
                    if (phone.isNotEmpty) {
                      makePhoneCall(phone); // Call the callback function
                    } else {
                      print('Phone number not available');
                    }
                  },
                  icon: Icon(Icons.call, color: Colors.brown.shade400,),),
              ],
            ),
          ),
        );
      },
    );
  }
}
