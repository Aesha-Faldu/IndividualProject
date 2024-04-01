import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../adminHome.dart';


class AdminCategory extends StatefulWidget{
  var index;
  var category_name;
  AdminCategory({@required this.index, @required this.category_name});

  @override
  AdminCategoryPage createState() => AdminCategoryPage(category_id: index,category_name: category_name);
}

class AdminCategoryPage extends State<AdminCategory> {
  var size;

  var category_id;
  var category_name;
  AdminCategoryPage({@required this.category_id, @required this.category_name});

  Future<List> viewCategoryItemsData() async{
    final responce = await http.get(Uri.parse("https://begrimed-executions.000webhostapp.com/Project_1/category_images.php/category_images_view.php?data="+category_id.toString()));
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context){
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("${category_name}",),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List>(
                future: viewCategoryItemsData(),
                builder: (ctx,ss) {
                  if(ss.hasData){
                    return Items(list:ss.data!,size: size);
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;
  var size;
  Items({required this.list,this.size});

  void deleteCategoryImages(var id){
    var url = "https://begrimed-executions.000webhostapp.com/Project_1/category_images.php/category_images_unique_delete.php";
    http.post(Uri.parse(url),body: {
      'data': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 1,
        crossAxisCount: 2,
        children: List.generate(list.length, (index) {
          return Column(
            children: [
              Image.network(list[index]['c_images'],
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return SizedBox(
                    height: size.height*17.4/100,
                    child: Center(
                      child: Icon(Icons.error,size: 40,),
                    ),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: size.height*17.4/100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                height: size.height*17.4/100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: size.height*5/100,
                width: double.infinity,
                decoration: BoxDecoration(
                ),
                child: TextButton(
                  child: Text("Delete".toUpperCase(),style: TextStyle(fontStyle: FontStyle.italic)),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Row(children: [Icon(Icons.delete,),Text("\tDelete",)],),
                        content: Text("This image will be permanently deleted",style: TextStyle(fontStyle: FontStyle.italic)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Cancel",),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteCategoryImages(list[index]['id']);
                              Fluttertoast.showToast(msg: "Image deleted Successfully",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>adminhomePage()));
                            },
                            child: Text("Delete",),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}