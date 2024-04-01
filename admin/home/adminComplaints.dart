import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class adminComplaints extends StatefulWidget
{
  @override
  adminComplaintsState createState() => adminComplaintsState();

}

class adminComplaintsState extends State<adminComplaints>
{
  late List list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.brown.shade400,
      body:
          Center(
            child: FutureBuilder<List>(
              future: getdetail(),
              builder: (ctx, ss) {
                if (ss.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (ss.hasError) {
                  print('Error: ${ss.error}');
                  return Text('Error fetching data. Please check your internet connection.');
                } else if (ss.hasData) {
                  return Items(list: ss.data!);
                } else {
                  return Text('No data available.');
                }
              },
            ),

          ),
    );
  }

  Future<List> getdetail() async {
    var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Complaints/view.php"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

class Items extends StatelessWidget
{
  List list;
  Items({required this.list});

  @override
  Widget build(BuildContext context)
  {

    return ListView.builder(

      itemCount: list==null ? 0 : list.length,
      itemBuilder: (ctx,i)
      {
        // int numberOfLines = (List[i]['complaints'].toString().length/25).ceil();
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 10),
          height: 150,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.deepPurple),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2), // changes the position of the shadow
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: ListTile(
                title: Text("Complaints: ${list[i]['complaints']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        );
      },
    );
  }
}

class member {
  final String complaints;

  member({
    required this.complaints,
  });

  factory member.fromJson(Map<String, dynamic> json) {
    return member(
      complaints: json['complaints'],
    );
  }
}

