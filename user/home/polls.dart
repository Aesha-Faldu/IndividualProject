import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Polls extends StatefulWidget {
  const Polls({Key? key}) : super(key: key);

  @override
  State<Polls> createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  Map<String, double> dataMap = {
    "Event": 18.25,
    "WorkerSalary": 28.75,
    "Bills": 32.08,
    "Others": 19.92,
  };

  List<Color> color = [
    const Color(0xff7a5ba8),
    const Color(0xff508383),
    const Color(0xff9f5f83),
    const Color(0xff0277bd),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Polls",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.brown.shade400,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Used Expenses:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: PieChart(
                dataMap: dataMap,
                colorList: color,
                chartRadius: MediaQuery.of(context).size.width / 2.5,
                centerText: "Polls",
                ringStrokeWidth: 24,
                animationDuration: const Duration(seconds: 3),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValues: true,
                  showChartValuesOutside: true,
                  showChartValuesInPercentage: true,
                  showChartValueBackground: false,
                ),
                legendOptions: const LegendOptions(
                  showLegends: true,
                  legendShape: BoxShape.rectangle,
                  legendTextStyle: TextStyle(fontSize: 15, color: Colors.black),
                  legendPosition: LegendPosition.bottom,
                  showLegendsInRow: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}