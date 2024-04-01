// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class ServiceProviders extends StatefulWidget
// {
//   @override
//   ServiceProvidersState createState() => ServiceProvidersState();
//
// }
//
// class ServiceProvidersState extends State<ServiceProviders>
// {
//   late List list;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Service Providers", style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.brown,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       backgroundColor: Colors.brown.shade400,
//       body:
//           Center(
//             child: FutureBuilder<List>(
//                 future: getdetail(),
//                 builder:(ctx,ss){
//
//                   if(ss.hasData)
//                   {
//
//                     return Items(list:ss.data!);
//
//                   }
//                   if(ss.hasError)
//                   {
//                     print('Network Not Found');
//                   }
//
//                   return CircularProgressIndicator();
//
//
//
//                 }),
//           ),
//     );
//   }
//
//   Future<List>getdetail()async
//   {
//     var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Service_Providers/view.php"));
//     return jsonDecode(response.body);
//   }
// }
//
// class Items extends StatelessWidget
// {
//   List list;
//   Items({required this.list});
//
//   @override
//   Widget build(BuildContext context)
//   {
//
//     return ListView.builder(
//
//       itemCount: list==null?0:list.length,
//       itemBuilder: (ctx,i)
//       {
//
//         return Container(
//           padding: EdgeInsets.all(5),
//           margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
//           height: 100,
//           width: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.deepPurple.withOpacity(0.7),
//                 spreadRadius: 3,
//                 blurRadius: 3,
//                 offset: Offset(0, 2), // changes the position of the shadow
//               ),
//             ],
//           ),
//           child: ListTile(
//
//
//             title: Text("Category : ${list[i]['category']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//             subtitle: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 80,
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 7,),
//                       Text("Name : ${list[i]['name']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                       SizedBox(height: 7,),
//                       Text("MobileNo : ${list[i]['mobileNo'.toString()]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// //
// // class member {
// //   final String firstName;
// //   final String lastName;
// //   final String gender;
// //   final String address;
// //   final String email;
// //   final String mobileNo;
// //   final String password;
// //
// //   member({
// //     required this.firstName,
// //     required this.lastName,
// //     required this.gender,
// //     required this.address,
// //     required this.email,
// //     required this.mobileNo,
// //     required this.password,
// //   });
// //
// //   factory member.fromJson(Map<String, dynamic> json) {
// //     return member(
// //       firstName: json['firstName'],
// //       lastName: json['lastName'],
// //       gender: json['gender'],
// //       address: json['address'],
// //       email: json['email'],
// //       mobileNo: json['phone'],
// //       password: json['Password'],
// //     );
// //   }
// // }
//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServiceProviders extends StatefulWidget {
  const ServiceProviders({super.key});

  @override
  State<ServiceProviders> createState() => _ServiceProviders();
}

class _ServiceProviders extends State<ServiceProviders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ServiceProviders", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.brown.shade400,
      body: Stack(
        children: [

          Center(
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

                }
            ),
          ),
        ],
      ),
    );
  }

  Future<List>getdetail()async
  {
    var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Service_Providers/view.php"));
    print(response.body.toString());
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
          padding: EdgeInsets.only(top: 10,),
          margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
          height: MediaQuery.of(context).size.height*0.2,
          width: MediaQuery.of(context).size.width*0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  offset: Offset(0,2),
                  blurRadius: 3,
                  spreadRadius: 3,
                )]
          ),

          child: ListTile(
            title: Text("category : ${list[i]['category']}", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),),
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
                      Text("Name : ${list[i]['name']}", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),),
                      SizedBox(height: 7,),
                      Text("MobileNo : ${list[i]['mobileNo'.toString()]}", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}