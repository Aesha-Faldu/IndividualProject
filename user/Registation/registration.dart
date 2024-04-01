import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Login/login.dart';
import '../home/home.dart';

enum Gender { Male, Female }

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  Gender? _gender;
  String? _selectedWing = 'A';
  List<String> wings = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "SuccessClub Society",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade400,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              Center(
                child: Text(
                  "Registration Form",
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.00,),
              _buildTextFormField(
                  "Enter First Name", "First Name", fname, Icons.person),
              SizedBox(height: 10.0),
              _buildTextFormField(
                  "Enter Last Name", "Last Name", lname, Icons.person),
              SizedBox(height: 10.0),
              _buildTextFormField(
                  "Enter Password", "Password", pass, Icons.lock,
                  isPassword: true),
              SizedBox(height: 10.0),
              _buildTextFormField(
                  "Confirm Password", "Confirm Password", cpass, Icons.lock,
                  isPassword: true),
              SizedBox(height: 10.0),
              _buildTextFormField("Enter Email", "Email", email, Icons.email,
                  keyboardType: TextInputType.emailAddress, isEmail: true),
              SizedBox(height: 10.0),
              _buildTextFormField(
                  "Enter PhoneNumber", "Phone", phone, Icons.phone,
                  keyboardType: TextInputType.phone, isPhoneNumber: true),
              SizedBox(height: 10.0),
              ListTile(
                title: Text("Gender"),
                subtitle: Row(
                  children: [
                    Radio(
                      value: Gender.Male,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: Gender.Female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ListTile(
                title: Text("Address (Wing)"),
                subtitle: DropdownButton(
                  value: _selectedWing,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedWing = newValue!;
                    });
                  },
                  items: wings.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // All validations pass
                    // Check if passwords match
                    if (pass.text != cpass.text) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Passwords do not match"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                   if (_gender == null) {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                     content: Text('Please select your gender'),
                   ));
                  }
                    else {
                      // Proceed with the signup process
                      var url = Uri.parse(
                          "https://aesha2002.000webhostapp.com/Digital_Society/Login_Register/register_insert.php");
                      http.post(url, body: {
                        "firstname": fname.text.toString(),
                        "lastname": lname.text.toString(),
                        "password": pass.text.toString(),
                        "confirm_password": cpass.text.toString(),
                        "email": email.text.toString(),
                        "phone": phone.text.toString(),
                        "gender": _gender
                            .toString()
                            .split('.')
                            .last, // Get the string value of enum
                        "address": _selectedWing.toString(),
                      });

                      // After successful registration, navigate to the home page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => homePage()),
                      );
                    }
                  }
                },
                child: Text("Sign up"),

              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: ()
                    {
                      print("Login button pressed");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("Already have an account? Login", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown),),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String labelText,
      String hintText,
      TextEditingController controller,
      IconData prefixIcon, {
        TextInputType? keyboardType,
        bool isPassword = false,
        bool isEmail = false,
        bool isPhoneNumber = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $hintText';
          }

          if (isEmail) {
            // Email formatting validation using regular expression
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
          }

          if (isPassword) {
            if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{6,}$').hasMatch(value)) {
              return 'Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
            }
          }

          if (isPhoneNumber) {
            if (value.length != 10) {
              return 'Phone number must be 10 digits';
            }
          }

          return null;
        },
      ),
    );
  }
}