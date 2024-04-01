import 'package:flutter/material.dart';
import 'adminFourWheelParking.dart';
import 'adminTwoWheelParking.dart';

class adminParking extends StatefulWidget {
  const adminParking({Key? key}) : super(key: key);

  @override
  State<adminParking> createState() => _adminParkingState();
}

class _adminParkingState extends State<adminParking> with SingleTickerProviderStateMixin
{
  TabController? _tabController;
  late String parkingType;
  late String a = '';
  late String b = '';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_handleTabChange);
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      // Handle the case where _tabController is null
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Slot", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'FOUR WHEEL',),
            Tab(text: "TWO WHEEL",),
          ],

          onTap: (index)
          {
            //your currently selected index
            print("poiu");
            print(index);

            if(index==0)
            {
              a="FourWheel";
            }
            else
            {
              b="TwoWheel";
            }
          },

          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,

        ),

      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          adminFourWheel(a),
          adminTwoWheel(b),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabChange()
  {
    int currentIndex = _tabController!.index;
    setState(() {
      parkingType = (currentIndex == 0 ? 'FourWheel' : 'TwoWheel') as String;
    });
    print("Tab Changed to index $currentIndex, Parking Type: $parkingType");
  }
}
