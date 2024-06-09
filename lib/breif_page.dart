import 'package:flutter/material.dart';

class breif extends StatelessWidget {
  const breif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              iconSize: 50,
              onPressed: () {
                Navigator.of(context).pushNamed("start");
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: Colors.blue,
            ),
            const SizedBox(
              width: 60,
            ),
            const Center(
              child: Image(
                image: AssetImage("lib/images/appbar_logo.jpeg"),
                height: 80,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                width: 200,
                image: AssetImage("lib/images/info.png"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
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
                    79,
                    251,
                  ),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("sign_in");
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
                    79,
                    251,
                  ),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("sign_up");
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: 500,
            height: 233.5,
            child: Image(
              width: 200,
              image: AssetImage("lib/images/girl_logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
