import 'package:flutter/material.dart';
import 'FourWheel.dart';
import 'TwoWheel.dart';

class Parking extends StatefulWidget {
  const Parking({Key? key}) : super(key: key);

  @override
  State<Parking> createState() => _ParkingState();
}

class _ParkingState extends State<Parking> with SingleTickerProviderStateMixin
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
          FourWheel(a),
          TwoWheel(b),
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
