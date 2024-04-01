import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../adminEvent.dart';

late String _myCategory;

class AdminUpload extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AdminUploadPage();
  }
}

class AdminUploadPage extends State<AdminUpload>
{
  var size;

  var upload_category = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  XFile? pickedFile;
  final String categoryMainUploadUrl = 'https://begrimed-executions.000webhostapp.com/upload_category/upload_category_main_image.php';
  final String categorySubUploadUrl = 'https://begrimed-executions.000webhostapp.com/upload_category/upload_category_sub_image_insert.php';

  late PickedFile _categoryImageFile;
  final String categoryUploadUrl = 'https://begrimed-executions.000webhostapp.com/upload_category/upload_category_sub_image_insert.php';

  void _pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print('pickImage ====> ${image!.path}');
        setState(() {});
        await uploadImage(image!.path, categoryMainUploadUrl + "?data=" + upload_category.text.toString());
      } else {
        print("Image picker canceled");
      }
    } catch (e) {
      print("Image picker error: $e");
    }
  }

  Future<String> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('profile_pic', filepath));
    var res = await request.send();
    return res.reasonPhrase!;
  }

  Future<List> getCategoryName() async {
    var data = await http.get(Uri.parse("https://begrimed-executions.000webhostapp.com/category/category_view.php"));
    return json.decode(data.body);
  }


  void _categoryPickImage() async {
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {});
        await categoryUploadImage(pickedFile!.path, categorySubUploadUrl + "?id=" + _myCategory.toString());
      } else {
        print("Category image picker canceled");
      }
    } catch (e) {
      print("Category image picker error: $e");
    }
  }

  Future<String> categoryUploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('profile_pic', filepath));
    var res = await request.send();
    return res.reasonPhrase!;
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      _myCategory = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(size.width*5/100 , size.height*33/100, size.width*5/100, 0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Row(children: [Icon(Icons.add,),Text("\tAdd Category",)],),
                        content: Container(
                          height: size.height*15/100,
                          child: Column(
                            children: [
                              TextField(
                                controller: upload_category,
                                decoration: InputDecoration(
                                  hintText: "Input Category Name",
                                ),
                              ),
                              SizedBox(height: size.height*1/100),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: double.infinity,
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if(upload_category.text.isNotEmpty){
                                      print('upload_category.text == ${upload_category.text}');
                                      _pickImage();
                                    }
                                    else{
                                      Fluttertoast.showToast(msg: "Please Input Category Name",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                    }
                                  },
                                  child: Text("Select Image".toUpperCase(),
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Cancel",),
                          ),
                          TextButton(
                            onPressed: () {
                              if(upload_category.text.isNotEmpty && image!=null){
                                Fluttertoast.showToast(msg: "Category Added Successfully",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                Navigator.of(ctx).pop();
                              }
                              else{
                                if(upload_category.text.isEmpty){
                                  Fluttertoast.showToast(msg: "Please Input Category Name",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                }
                                else if(image==null){
                                  Fluttertoast.showToast(msg: "Please Select Category Image",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                }
                              }
                            },
                            child: Text("Add",),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Upload Category".toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*2/100),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width*5/100 , 0, size.width*5/100, size.height*33/100),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Row(children: [Icon(Icons.upload),Text("\tUpload Images",)],),
                        content: Container(
                          height: size.height*14/100,
                          child: Column(
                            children: [
                              Expanded(
                                child: FutureBuilder<List>(
                                  future: getCategoryName(),
                                  builder: (ctx,ss) {
                                    if(ss.hasData){
                                      return Items(list:ss.data!);
                                    }
                                    else{
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: size.height*1/100),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: double.infinity,
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if(_myCategory!=null){
                                      print('_categoryPickImage');
                                      _categoryPickImage();
                                    }
                                    else{
                                      Fluttertoast.showToast(msg: "Please Select Category",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                    }
                                  },
                                  child: Text("Select Images".toUpperCase(),
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              if(_myCategory!=null && pickedFile!=null){
                                Fluttertoast.showToast(msg: "Images Uploaded Successfully",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                Navigator.of(ctx).pop();
                              }
                              else{
                                if(_myCategory == null){
                                  Fluttertoast.showToast(msg: "Please Select Category",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                }
                                else if(pickedFile==null){
                                  Fluttertoast.showToast(msg: "Please Select Images",toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1);
                                }
                              }
                            },
                            child: Text("Upload",),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Upload Images".toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Items extends StatefulWidget {
  List list;
  Items({required this.list});

  @override
  State<StatefulWidget> createState() {
    return _Items(list_: list);
  }
}

class _Items extends State<Items>{
  List list_;
  _Items({required this.list_});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        hint: Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*14/100, 0, 0, 0),
          child: Text("Select Category",),
        ),
        items: list_.map((item) {
          return DropdownMenuItem(
            child: Text(item['category_name']),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _myCategory = newVal!;
          });
        },
        value: _myCategory,
      ),
    );
  }
  void navigateToEventPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => adminEvents()),
    );
  }
}