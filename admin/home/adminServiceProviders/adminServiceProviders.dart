import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/admin/home/adminServiceProviders/adminServiceView.dart';

import '../../../user/home/serviceProviders.dart';

class adminServiceProvider extends StatefulWidget
{
  @override
  State<adminServiceProvider> createState() => _adminServiceProviderState();
}

class _adminServiceProviderState extends State<adminServiceProvider>
{
  TextEditingController category = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();


  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(title:Text("Service Provider",style: TextStyle(
        color: Colors.white
      ),),

      backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center
          (
          child: Container
            (
            child: Column

              (
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [

                TextField
                  (
                  controller: category,
                  decoration: InputDecoration(
                  labelText: "category Name",
                    labelStyle: TextStyle(color: Colors.brown),
                    hintText: "Plumber, Electrician, etc..",
                    prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.brown),
                ),
                ),),

                SizedBox(height: 20,),
                TextField
                  (
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Enter Name of  worker",
                    labelStyle: TextStyle(color: Colors.brown),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),),

                SizedBox(height: 20,),
                TextField
                  (
                  controller: mobileNo,
                  decoration: InputDecoration(
                    labelText: "Mobile No.",
                    labelStyle: TextStyle(color: Colors.brown),
                    prefixIcon: Icon(Icons.phone_callback_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()
                  {

                    var url = Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Service_Providers/insert.php");

                    http.post(url,
                        body:
                        {
                          "category":category.text.toString(),
                          "name":name.text.toString(),
                          "mobileNo":mobileNo.text.toString(),
                        });
                    print('Inserted');
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ServiceProviders()));
                  }, child: Text("Send",style: TextStyle(color: Colors.white),),

                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  ),
                ),

                SizedBox(height: 20,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => adminServiceView(list: category, index: 0)));
                      },
                      child: Text("View Service Providers Page", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
              ),
            ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}