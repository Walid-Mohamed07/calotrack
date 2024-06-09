import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("lib/images/logo.png"),
              ),
            ],
          ),
          const Text(
            "CALOTRACK",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(
                    255,
                    3,
                    80,
                    244,
                  ),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Color.fromARGB(
                          255,
                          2,
                          15,
                          225,
                        ),
                        width: 2),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("breif");
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    "START",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
