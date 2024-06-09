import 'dart:convert';
import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'recipes.dart';

class RECIPEDETAILS extends StatefulWidget {
  const RECIPEDETAILS({super.key});

  @override
  State<RECIPEDETAILS> createState() => _RECIPEDETAILSState();
}

class _RECIPEDETAILSState extends State<RECIPEDETAILS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BOTTOMBAR(),
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                recipeDetails,
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
                  width: 8,
                ),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        base64.decode(image),
                        height: 150,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(
                  width: 10,
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
                            "$recipe_p",
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
                            "$recipe_c",
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
                            "$recipe_f",
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
                            child: const Text(""),
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
                            "$recipe_cal",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0, 6.0),
                  child: Text(
                    "Prep time: $prep_time",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2.0, 8.0, 6.0),
                  child: Text(
                    "Cook time: $cook_time",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(1.0),
                //   child: Text(
                //     "Total time: $total_time",
                //     style: const TextStyle(
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Ingredients",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ingredients),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Steps",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(steps),
            ),
          ],
        ),
      ),
    );
  }
}
