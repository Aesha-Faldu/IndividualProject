import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:project/user/Registation/registration.dart';
import 'package:project/user/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../admin/home/adminHome.dart';
class LoginPage extends StatefulWidget
{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  var sessionData;
  var identifier_data;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  late SharedPreferences logindata;
  late bool newuser;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    checkifalreadylogin();
  }


  Future viewData() async {

    const String adminPhone = "9913070101";
    const String adminPassword = "admin123";

    if (phone.text == adminPhone && password.text == adminPassword) {
      logindata.setBool('login', false);
      logindata.setString('phone', phone.text.toString());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => adminhomePage()));
    } else {
      showSnackbar("Login failed. Please check your credentials.");
    }
    var url = Uri.parse(
        "https://aesha2002.000webhostapp.com/Digital_Society/Login_Register/login_view.php");

    var response = await http.post(url,
        body:
        {
          "phone": phone.text.toString(),
          "password": password.text.toString(),
        });
    var data = json.decode(response.body);
    if (data == 0) {
      print("Loggin Fail");
      showSnackbar("Login failed. Please check your credentials.");
    }
    else {
      print("login done");
      logindata.setBool('login', false);
      logindata.setString('phone', phone.text.toString());
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => homePage()));
    }
  }
      @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "SuccessClub Society", // Update the app bar title
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade400, // Change the background color
      ),
      body:Padding(
          padding: EdgeInsets.all(16.0),
          child: Center
            (
            child: Container
              (
              child: Column
                (
                children:
                [
                  Text(
                    "Login Form",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.brown.shade300,
                      decoration: TextDecoration.none, // Add underline decoration
                      decorationColor: Colors.white, // Set underline color
                      decorationThickness: 2, // Set underline thickness
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ), // Add shadow for a more appealing look
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      labelText: "Enter your MobileNumber",
                      prefixIcon: Icon(Icons.phone_callback_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                    ),

                    keyboardType: TextInputType.number,  // Specify the number keyboard
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,  // Allow only numeric input
                      LengthLimitingTextInputFormatter(10),  // Limit to 10 characters
                    ],
                    onFieldSubmitted: (value) {
                      phone.text = value.toString();
                    },
                    onSaved: (value) {
                      phone.text = value.toString();
                    },
                    validator: (value) {
                      if (value
                          .toString()
                          .isEmpty) {
                        return "Enter MobileNumber";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),

                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      labelText: "Enter  your Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    onFieldSubmitted: (value) {
                      password.text = value.toString();
                    },
                    onSaved: (value) {
                      password.text = value.toString();
                    },
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Enter your Password";
                      }

                      if (!isValidPassword(value.toString())) {
                        return "Password must have at least 6 characters, including uppercase, lowercase, digit, and special character.";
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 10,),

                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(onPressed: (){
                      viewData();
                      if ( !password.text.isEmpty && !phone.text.isEmpty && phone.text.length==10) {

                      }
                      else{
                        if(password.text.isEmpty){
                          showSnackbar("Enter Your Password");
                        }
                        else if(phone.text.isEmpty ){
                          showSnackbar("Enter Your PhoneNumber");
                        }
                        else if(phone.text.length!=10){
                          showSnackbar("Enter Valid PhoneNumber");
                        }
                      }
                      },
                        child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                      primary: Colors.brown.shade300,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.brown.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  void checkifalreadylogin() async
  {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);

    if (newuser == false)
    {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => homePage()));
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[a-z0-9._-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}$');
    return emailRegex.hasMatch(email);
  }
  bool isValidPassword(String password) {
    final RegExp passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{6,}$');
    return passwordRegex.hasMatch(password);
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

}
