import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class adminServiceView extends StatefulWidget
{
  late List<Map<String, dynamic>> list;
  late int index;
  adminServiceView({required list, required index});

  @override
  adminServiceViewState createState() => adminServiceViewState();

}

class adminServiceViewState extends State<adminServiceView>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Providers",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade400,
      body: Center(
            child: FutureBuilder<List>(
                future: getdetail(),
                builder:(ctx,ss){

                  if(ss.hasData)
                  {

                    return Items(list:ss.data!);

                  }
                  if(ss.hasError)
                  {
                    print('Network Not Found');
                  }

                  return CircularProgressIndicator();



                }),
          ),
    );
  }

  Future<List>getdetail()async
  {
    var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Service_Providers/view.php"));
    return jsonDecode(response.body);
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

        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
          height: 100,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.white24.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2), // changes the position of the shadow
              ),
            ],
          ),
          child: ListTile(


            title: Text("Category : ${list[i]['category']}", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),),
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
                      SizedBox(height: 7,),
                      Text("Name : ${list[i]['name']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      SizedBox(height: 7,),
                      Text("MobileNo : ${list[i]['mobileNo']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: ()
              {
                _delete(list[i]['id'].toString(), context);
              },
              icon: Icon(Icons.delete, color: Colors.white,),),
          ),
        );
      },
    );
  }
  Future<void> _delete(String id, BuildContext context) async {
    try {
      var url = Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Service_Providers/delete.php");
      var response = await http.delete(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'id': id}),
      );

      if (response.statusCode == 200) {
        print("Service Provider deleted successfully");
        // Perform any other actions after successful deletion
      } else {
        print("Failed to delete Service Provider. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        // Handle error as needed
      }
    } catch (e) {
      print("Error deleting Service Provider: $e");
      // Handle error as needed
    }
  }

}
//
// class member {
//   final String firstName;
//   final String lastName;
//   final String gender;
//   final String address;
//   final String email;
//   final String mobileNo;
//   final String password;
//
//   member({
//     required this.firstName,
//     required this.lastName,
//     required this.gender,
//     required this.address,
//     required this.email,
//     required this.mobileNo,
//     required this.password,
//   });
//
//   factory member.fromJson(Map<String, dynamic> json) {
//     return member(
//       firstName: json['FirstName'],
//       lastName: json['LastName'],
//       gender: json['Gender'],
//       address: json['Address'],
//       email: json['Email'],
//       mobileNo: json['MobileNo'],
//       password: json['Password'],
//     );
//   }
// }

