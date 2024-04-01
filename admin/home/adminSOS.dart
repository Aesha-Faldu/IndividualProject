import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class adminSOS extends StatefulWidget {
  const adminSOS({super.key});

  @override
  State<adminSOS> createState() => _adminSOSState();
}

class _adminSOSState extends State<adminSOS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.brown.shade400,
      body:
          Center(
            child: Column(
              children: [
                SizedBox(height: 190,),
                GestureDetector(
                  onTap: ()
                  {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          color: Colors.amber,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(220),
                      color: Colors.redAccent,
                    ),
                    child: TextButton(
                      onPressed: ()
                      {
                        _makeEmergencyCall();
                      }, child: Text("SOS", style: TextStyle(color: Colors.white, fontSize: 40),),

                    ),
                  ),
                ),

                SizedBox(height: 70,),
                Text("Press above button if you have Emergency.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),)
              ],
            ),
          ),
    );
  }

  void _makeEmergencyCall() async
  {
    const url = 'tel:112'; // Replace with the actual emergency number
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
