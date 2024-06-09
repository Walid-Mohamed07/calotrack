import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'home_page.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';

class ITEMDETAILS extends StatefulWidget {
  const ITEMDETAILS({super.key});

  @override
  State<ITEMDETAILS> createState() => _ITEMDETAILSState();
}

class _ITEMDETAILSState extends State<ITEMDETAILS> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BOTTOMBAR(),
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 50,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.blue,
        ),
        titleSpacing: 90,
        title: const Image(
          image: AssetImage("lib/images/appbar_logo.jpeg"),
          height: 80,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              itemDetails,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 23,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Nutrition",
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              AnimatedCircularChart(
                key: _chartKey,
                size: const Size(150, 100),
                initialChartData: [
                  CircularStackEntry(
                    <CircularSegmentEntry>[
                      CircularSegmentEntry(
                        item_p,
                        Colors.red,
                        rankKey: 'Q1',
                      ),
                      CircularSegmentEntry(
                        item_c,
                        Colors.green,
                        rankKey: 'Q2',
                      ),
                      CircularSegmentEntry(
                        item_f,
                        Colors.blue,
                        rankKey: 'Q3',
                      ),
                      CircularSegmentEntry(
                        item_cal,
                        Colors.yellow,
                        rankKey: 'Q4',
                      ),
                    ],
                  ),
                ],
                chartType: CircularChartType.Radial,
              ),
              const SizedBox(
                width: 20,
              ),
              IntrinsicWidth(
                stepWidth: 40,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(" "),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 60,
                          child: Text(
                            "Proteins:",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          "$item_p",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(" "),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 60,
                          child: Text(
                            "Carbs:",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          "$item_c",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(" "),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 60,
                          child: Text(
                            "Fat:",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          "$item_f",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(" "),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 60,
                          child: Text(
                            "Calories:",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          "$item_cal",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 350,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 226, 226),
                shape: BoxShape.rectangle,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1200-Calorie Meal Plan"),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("1200_meal_plan");
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 350,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 226, 226),
                shape: BoxShape.rectangle,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2000-Calorie Meal Plan"),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("2000_meal_plan");
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 350,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 226, 226),
                shape: BoxShape.rectangle,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("3000-Calorie Meal Plan"),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("3000_meal_plan");
            },
          ),
        ],
      ),
    );
  }
}
