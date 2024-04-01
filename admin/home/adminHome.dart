import 'package:app_settings/app_settings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../User/login/login.dart';
import '../../user/constants.dart';
import 'Events/adminEvent.dart';
import 'Events/category.dart';
import 'adminComplaints.dart';
import 'adminEvent.dart';
import 'adminMembers.dart';
import 'adminNoticeBoard/adminNoticeBoard.dart';
import 'adminParking/adminParking.dart';
import 'adminPolls.dart';
import 'adminSOS.dart';
import 'adminServiceProviders/adminServiceProviders.dart';
import 'adminVisitors.dart';

class adminhomePage extends StatefulWidget {
  adminhomePage({super.key});

  @override
  State<adminhomePage> createState() => _adminhomePageState();
}

class _adminhomePageState extends State<adminhomePage>
{
  late SharedPreferences logindata;

  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    logindata = await SharedPreferences.getInstance();
  }

  List<String> names =
  [
    membersName,
    noticeBoardName,
    // name3,
    eventsName,
    visitorsName,
    serviceProvidersName,
    // name7,
    parkingName,
    sosName,
    complaintsName,
    // name11,
    pollsName,
  ];

  List<String> icons =
  [
    memberIcon,
    noticeBoardIcon,
    // icon3,
    eventsIcon,
    visitorsIcon,
    serviceProvidersIcon,
    // icon7,
    parkingIcon,
    sosIcon,
    complaintsIcon,
    // icon11,
    pollsIcon,
  ];

  late List<String> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(title: Text("Smart Society", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async{
                await logindata.remove('login');
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => LoginPage()));
              }, icon: Icon(Icons.logout, color: Colors.white,)),
        ],
      ),


      drawer: Container(
        color: Colors.brown,
        child: Drawer(
          backgroundColor: Colors.brown.shade300.withOpacity(0.2),
          surfaceTintColor: Colors.white,
          child: ListView(
            // padding: EdgeInsets.all(10.00),
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.brown,),
                accountName: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                currentAccountPicture: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage("images/members.png",),
                  backgroundColor: Colors.white,
                ),
                accountEmail: Text("Email"),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Images',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => adminEvents()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.archive,
                  color: Colors.white,
                ),
                title: const Text(
                  'Archieved',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Nothing is Archieved")),
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                title: const Text(
                  'Trash',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Nothing is Deleted")),
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  AppSettings.openAppSettings();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),

        child: CarouselSlider(
            items: [
            Image.asset('images/slider-1.jpg',fit: BoxFit.fitWidth,),
            Image.asset('images/slider2.png',fit: BoxFit.fitWidth,),
            Image.asset('images/slider3.jpg',fit: BoxFit.fitWidth,),
          ],
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16/5,
            onPageChanged: (index, reason) {
              // Handle page change
            },
          ),
        ),),
        SizedBox(height: 20.00,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.brown.shade300,
                  child: ListView.builder(
                    itemCount: icons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          switch (index) {
                            case 0:
                              if (names[index] == membersName && icons[index] == memberIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminMembers()));
                              }
                              break;
                            case 1:
                              if (names[index] == noticeBoardName && icons[index] == noticeBoardIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminNoticeBoard()));
                              }
                              break;
                            case 5:
                              if (names[index] == parkingName && icons[index] == parkingIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminParking()));
                              }
                              break;
                            case 2:
                              if (names[index] == eventsName && icons[index] == eventsIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminEvents()));
                              }
                              break;
                            case 4:
                              if (names[index] == serviceProvidersName && icons[index] == serviceProvidersIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminServiceProvider()));
                              }
                              break;
                            case 3:
                              if (names[index] == visitorsName && icons[index] == visitorsIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminVisitors()));
                              }
                              break;
                            case 7:
                              if (names[index] == complaintsName && icons[index] == complaintsIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminComplaints()));
                              }
                              break;
                            case 8:
                              if (names[index] == pollsName && icons[index] == pollsIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminPolls()));
                              }
                              break;
                            case 6:
                              if (names[index] == sosName && icons[index] == sosIcon) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => adminSOS()));
                              }
                              break;
                            default:
                            // Handle default case if needed
                          }
                        },
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(10),

                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Container(
                                  width: 50,
                                 height: 50,
                                 alignment: Alignment.centerLeft,
                                 decoration: BoxDecoration(
                                  image: DecorationImage(
                                  image: AssetImage(icons[index],),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                                  title: Text(names[index],
                                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
                          ),
                                  trailing: Icon(Icons.navigate_next_rounded,size: 20,color: Colors.black,),

                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
