import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MEALPLAN2 extends StatefulWidget {
  const MEALPLAN2({super.key});

  @override
  State<MEALPLAN2> createState() => _MEALPLAN2State();
}

class _MEALPLAN2State extends State<MEALPLAN2> {
  List planDetails2 = [];
  PlanDetails2() async {
    var response = await http.post(
      Uri.parse("https://caltrack.atwebpages.com/CRUD/meals/getAll.php"),
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data != null) {
      setState(() {
        planDetails2 = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    PlanDetails2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              iconSize: 50,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: Colors.blue,
            ),
            const SizedBox(
              width: 30,
            ),
            const Center(
              child: Text(
                "Diet Meal Plan",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                width: 300,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 226, 226),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      planDetails2.isNotEmpty ? planDetails2[1]["title"] : "",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Brakfast (${planDetails2.isNotEmpty ? planDetails2[1]["breakfast_cals"] : ""})",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.blue,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${planDetails2.isNotEmpty ? planDetails2[1]["breakfast"] : ""}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lunch (${planDetails2.isNotEmpty ? planDetails2[1]["lunch_cals"] : ""})",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.blue,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${planDetails2.isNotEmpty ? planDetails2[1]["lunch"] : ""}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dinner (${planDetails2.isNotEmpty ? planDetails2[1]["dinner_cals"] : ""})",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.blue,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${planDetails2.isNotEmpty ? planDetails2[1]["dinner"] : ""}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
