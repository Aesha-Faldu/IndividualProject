import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints>
{
  TextEditingController complaints = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complaints", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.brown.shade400,
      body: Container(

        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: complaints,
                  decoration: InputDecoration(
                    labelText: "Enter Message (with Name and FlatNo)",
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                ),
              ),

              SizedBox(height: 10,),

              ElevatedButton(
                onPressed: ()
                {
                  setState(() {
                    print("1");
                    print("Clicked");
                    var url = Uri.parse(
                        "https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Complaints/insert.php");
                    http.post(url,

                        body:
                        {
                          "complaints": complaints.text.toString(),
                        }
                    );
                    complaints.text = "";
                    print("yes");

                    print(complaints.text.toString());
                  }
                  );
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => adminComplaints()));
                },
                child: Text("Send", style: TextStyle(color: Colors.brown),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
