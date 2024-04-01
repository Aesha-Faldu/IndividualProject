import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../onboarding/introscreen.dart';
class loadingscreen extends StatefulWidget
{
  @override
  loadingscreenState createState() =>loadingscreenState();
}

class loadingscreenState extends State<loadingscreen>
{
  @override void initState() {
    // TODO: implement initState
    // super.initState();
    checkconnection();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("images/splash.json", height: 200, width: 200),
      ),
    );
  }

  void checkconnection() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult==ConnectivityResult.mobile)
    {
      Timer(
          Duration(seconds: 2),() =>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TestScreen()))
      );
    }
    if(connectivityResult==ConnectivityResult.wifi)
    {
      Timer(Duration(seconds: 3), ()=>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TestScreen())),
      );
    }
    else
    {
      _showConnectionDialog();
    }
  }

  _showConnectionDialog()async
  {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog
            (
            backgroundColor: Colors.black26,
            title: Row(children: [Icon(Icons.error), Text("\tNetwork Error")],),
            content: Text('Please check your internet connection.',
                style: TextStyle(fontStyle: FontStyle.italic)),
            actions: <Widget>
            [
              ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: Text("Exit", style: TextStyle(color: Colors.grey)),
              ),
            ],
          );
        });
  }
}