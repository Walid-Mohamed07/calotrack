import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MEALPLAN extends StatefulWidget {
  const MEALPLAN({super.key});

  @override
  State<MEALPLAN> createState() => _MEALPLANState();
}

class _MEALPLANState extends State<MEALPLAN> {
  List planDetails = [];
  PlanDetails() async {
    var response = await http.post(
      Uri.parse("https://caltrack.atwebpages.com/CRUD/meals/getAll.php"),
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data != null) {
      setState(() {
        planDetails = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    PlanDetails();
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
                      planDetails.isNotEmpty ? planDetails[0]["title"] : "",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Brakfast (${planDetails.isNotEmpty ? planDetails[0]["breakfast_cals"] : ""})",
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
                "${planDetails.isNotEmpty ? planDetails[0]["breakfast"] : ""}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lunch (${planDetails.isNotEmpty ? planDetails[0]["lunch_cals"] : ""})",
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
                "${planDetails.isNotEmpty ? planDetails[0]["lunch"] : ""}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dinner (${planDetails.isNotEmpty ? planDetails[0]["dinner_cals"] : ""})",
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
                "${planDetails.isNotEmpty ? planDetails[0]["dinner"] : ""}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
