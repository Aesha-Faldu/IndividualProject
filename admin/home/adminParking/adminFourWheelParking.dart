import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class adminFourWheel extends StatefulWidget {
  final String parkingType;

  adminFourWheel(this.parkingType);

  @override
  State<adminFourWheel> createState() => _adminFourWheelState();
}

class _adminFourWheelState extends State<adminFourWheel> {
  late List list;
  TextEditingController flatNo = TextEditingController();
  TextEditingController vehicleNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade400,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder<List>(
                future: getDetail(),
                builder: (ctx, ss) {
                  if (ss.hasData) {
                    return Items(list: ss.data!, parkingType: widget.parkingType);
                  }
                  if (ss.hasError) {
                    print('Network Not Found');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add Vehicle",
                  style: TextStyle(color: Colors.brown),
                ),
                content: _buildForm(),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 200,
      width: 300,
      child: Column(
        children: [
          TextField(
            controller: flatNo,
            decoration: InputDecoration(
              labelText: "Flat No",
              labelStyle: TextStyle(color: Colors.brown),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
          ),
          TextField(
            controller: vehicleNo,
            decoration: InputDecoration(
              labelText: "Vehicle No",
              labelStyle: TextStyle(color: Colors.brown),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.brown),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _addVehicle();
            },
            child: Text("ADD", style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
          )
        ],
      ),
    );
  }

  Future<List> getDetail() async {
    var response = await http.get(Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Parking/view.php"));
    return jsonDecode(response.body);
  }

  void _addVehicle() {
    setState(() {
      print("Clicked");
      var url = Uri.parse("https://aesha2002.000webhostapp.com/Digital_Society/Digital_Society_Parking/insert.php");
      http.post(
        url,
        body: {
          "flatNo": flatNo.text.toString(),
          "vehicleNo": vehicleNo.text.toString(),
          "parkingType": widget.parkingType,
        },
      );
      flatNo.text = "";
      vehicleNo.text = "";
      print("Data sent successfully");
    });
  }
}

class Items extends StatelessWidget {
  List list;
  final String parkingType;
  Items({required this.list, required this.parkingType});

  @override
  Widget build(BuildContext context) {
    List filteredList = list.where((vehicle) => vehicle['parkingType'] == parkingType).toList();

    if (filteredList.isEmpty) {
      return Center(
        child: Text('No vehicles found for the selected parking type.', style: TextStyle(color: Colors.white),),
      );
    }

    return ListView.builder(
      itemCount: filteredList == null ? 0 : filteredList.length,
      itemBuilder: (ctx, i) {
        return Container(
          padding: EdgeInsets.only(top: 10,),
          margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
          height: 90,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            title: Text("Flat No : ${filteredList[i]['flatNo']}",
                style: TextStyle(
                    color: Colors.brown, fontWeight: FontWeight.bold)),
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
                      SizedBox(
                        height: 7,
                      ),
                      Text("VehicleNo : ${filteredList[i]['vehicleNo']}",
                          style: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 7,
                      ),
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
