import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ageFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "age Field can\'t be empty" : null;
  }
}

class weightFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "weight Field can\'t be empty" : null;
  }
}

class heightFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Password Field can\'t be empty" : null;
  }
}

class SIGNUP2 extends StatefulWidget {
  const SIGNUP2({super.key});

  @override
  State<SIGNUP2> createState() => _Signup2state();
}

String name = "";
String email = "";
String password = "";

setName(String n) {
  name = n;
}

setemail(String e) {
  email = e;
}

setpassword(String p) {
  password = p;
}

class _Signup2state extends State<SIGNUP2> {
  final TextEditingController age = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();
  bool firstSelect = false;
  bool selected = false;
  String gender = "";

  Future SignUp2(BuildContext cont) async {
    if (age.text == "" ||
        weight.text == "" ||
        height.text == "" ||
        gender == "") {
      Fluttertoast.showToast(
        msg: "The gender or age or weight or height fields can't be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
    } else {
      String url = "https://caltrack.atwebpages.com/registration/signup.php";
      var response = await http.post(Uri.parse(url), body: {
        "user_name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "age": age.text,
        "weight": weight.text,
        "height": height.text,
        "user_picture": "",
      });
      String data = json.decode(response.body);
      if (data == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("breif", (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: "The email is already exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
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
              width: 60,
            ),
            const Center(
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
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
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.pinkAccent,
                  onTap: () {
                    setState(() {
                      firstSelect = true;
                      selected = true;
                      gender = "Male";
                    });
                  },
                  child: Card(
                    color: firstSelect
                        ? selected
                            ? const Color(0xFF3B4257)
                            : Colors.white
                        : Colors.white,
                    child: Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.male,
                            color: selected ? Colors.white : Colors.grey,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Male",
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.pinkAccent,
                  onTap: () {
                    setState(() {
                      firstSelect = true;
                      selected = false;
                      gender = "Female";
                    });
                  },
                  child: Card(
                    color: firstSelect
                        ? !selected
                            ? const Color(0xFF3B4257)
                            : Colors.white
                        : Colors.white,
                    child: Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.female,
                            color: firstSelect
                                ? !selected
                                    ? Colors.white
                                    : Colors.grey
                                : Colors.grey,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Female",
                            style: TextStyle(
                              color: firstSelect
                                  ? !selected
                                      ? Colors.white
                                      : Colors.grey
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  key: const Key("age"),
                  validator: (value) => ageFieldValidator.validate(value!),
                  keyboardType: TextInputType.text,
                  controller: age,
                  decoration: const InputDecoration(
                      hintText: "Age",
                      icon: Icon(Icons.add_chart_outlined),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  key: const Key("Weight"),
                  validator: (value) => weightFieldValidator.validate(value!),
                  keyboardType: TextInputType.text,
                  controller: weight,
                  decoration: const InputDecoration(
                      hintText: "weight",
                      icon: Icon(Icons.add_chart_outlined),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  key: const Key("Height"),
                  validator: (value) => heightFieldValidator.validate(value!),
                  keyboardType: TextInputType.text,
                  controller: height,
                  decoration: const InputDecoration(
                      hintText: "Height",
                      icon: Icon(Icons.add_chart_outlined),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
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
                  SignUp2(context);
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: const Text(
                      "Sign Up",
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
          ],
        ),
      ),
    );
  }
}
