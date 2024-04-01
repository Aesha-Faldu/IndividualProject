import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late List<Map<String, dynamic>> list;

  List<String> images = [
    "https://aesha2002.000webhostapp.com/Digital_Society/images/diwalii.jpg",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/ganeshchaturthi.jpg",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/holi1.jpg",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/janmashtmi.jpg",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/makarsankranti.jpg",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/navratri.jpg",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/ramnavmi.png",
    "https://aesha2002.000webhostapp.com/Digital_Society/images/republicday.jpg",
  ];

  List<String> names = [
    "Diwali",
    "Ganesh Chaturthi",
    "Holi",
    "Janmashtami",
    "Makarsankranti",
    "Navratri",
    "Ramavami",
    "Republic day",
  ];

  @override
  void initState() {
    super.initState();
    list = List.generate(images.length, (index) {
      return {
        'image': images[index],
        'name': names[index],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        color: Colors.brown.shade400,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text("We Celebrate Events Like...", style: TextStyle(color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 9.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ), // Add shadow for a more appealing look
                  ],
                  fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 30,),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Card(
                            elevation:5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(list[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  list[index]['name'],
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
