import 'package:app_settings/app_settings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/user/home/serviceProviders.dart';
import 'package:project/user/home/visitors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/login.dart';
import '../constants.dart';
import 'Complaints.dart';
import 'NoticeBoard.dart';
import 'Parking/Parking.dart';
import 'SOS.dart';
import 'events.dart';
import 'polls.dart';
import 'members.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<String> names = [
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

  List<String> icons = [
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

  late String MobileNo;
  late SharedPreferences logindata;

  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      MobileNo = logindata.getString('MobileNo') ?? '';
    });
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(
        title: Text(
          "Smart Society",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            onPressed: () {
              logindata.setBool('login', true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
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
                    MaterialPageRoute(builder: (context) => Events()),
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
      body: Column(
          children: [
        SizedBox(height: 20.00,),
        CarouselSlider(
          items: [
            Image.asset(
              'images/slider-1.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'images/slider2.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'images/slider3.jpg',
              fit: BoxFit.cover,
            ),
          ],
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 5, // Adjust as needed
            onPageChanged: (index, reason) {
              // Handle page change
            },
          ),
        ),



        SizedBox(height: 20.00,),
        Expanded(
          child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    switch (index) {
                      case 0:
                        if (names[index] == membersName &&
                            icons[index] == memberIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Members()),
                          );
                        }
                        break;
                      case 1:
                        if (names[index] == noticeBoardName &&
                            icons[index] == noticeBoardIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeBoard()),
                          );
                        }
                        break;
                      case 2:
                        if (names[index] == eventsName &&
                            icons[index] == eventsIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Events()),
                          );
                        }
                        break;
                      case 5:
                        if (names[index] == parkingName &&
                            icons[index] == parkingIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Parking()),
                          );
                        }
                        break;
                      case 4:
                        if (names[index] == serviceProvidersName &&
                            icons[index] == serviceProvidersIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceProviders()),
                          );
                        }
                        break;
                      case 3:
                        if (names[index] == visitorsName &&
                            icons[index] == visitorsIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => visitors()),
                          );
                        }
                        break;
                      case 7:
                        if (names[index] == complaintsName &&
                            icons[index] == complaintsIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Complaints()),
                          );
                        }
                        break;
                      case 8:
                        if (names[index] == pollsName &&
                            icons[index] == pollsIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Polls()),
                          );
                        }
                      case 6:
                        if (names[index] == sosName &&
                            icons[index] == sosIcon) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SOS()),
                          );
                        }

                      default:
                      // Handle default case if needed
                    }
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      icons[index],
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              title: Text(
                                names[index],
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              trailing: Icon(
                                Icons.navigate_next_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
