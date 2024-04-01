import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notice", style: TextStyle(color: Colors.white),),
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
    var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Notice_Board/view.php"));
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
            title: Text("Message: ${list[i]['text']}", style: TextStyle(color: Colors.brown),),
          ),
        );
      },
    );
  }
}