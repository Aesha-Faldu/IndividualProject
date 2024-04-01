import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Members extends StatefulWidget
{
  @override
  MembersState createState() => MembersState();

}

class MembersState extends State<Members>
{
  late List list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade400,
      body:
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



                }),
          ),

    );
  }

  Future<List>getdetail()async
  {
    var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Login_Register/register_view.php"));
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

      itemCount: list==null?0:list.length,
      itemBuilder: (ctx,i)
      {

        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          height: 100,
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


              title: Text("firstname:${list[i]['firstname']} " " lastname:${list[i]['lastname']}", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),),
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
                        Text("gender: ${list[i]['gender']}", style: TextStyle(color: Colors.brown),),
                        Text("address(Wing): ${list[i]['address']}", style: TextStyle(color: Colors.brown),),
                        Text("Email: ${list[i]['email']}", style: TextStyle(color: Colors.brown),),
                      ],
                    ),
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}

