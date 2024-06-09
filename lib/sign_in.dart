import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Email Field can\'t be empty" : null;
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Password Field can\'t be empty" : null;
  }
}

bool secure = true;
String token = "";

getToken() {
  return token;
}

class SIGNIN extends StatefulWidget {
  const SIGNIN({super.key});

  @override
  State<SIGNIN> createState() => _SignInState();
}

class _SignInState extends State<SIGNIN> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future SignIn(BuildContext cont) async {
    if (email.text == "" || password.text == "") {
      Fluttertoast.showToast(
        msg: "The email or the password field can't be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
    } else {
      String url = "https://caltrack.atwebpages.com/registration/login.php";
      var response = await http.post(Uri.parse(url),
          body: {"email": email.text, "password": password.text});
      String data = json.decode(response.body);
      if (data != "error") {
        setState(() {
          token = data;
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil("home_page", (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: "The email and password does not exist",
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
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
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
                "Sign in",
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
              height: 150,
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
                  key: const Key("Email"),
                  validator: (value) => EmailFieldValidator.validate(value!),
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: const InputDecoration(
                      hintText: "Email Address",
                      icon: Icon(Icons.mail),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: TextFormField(
                key: const Key("Password"),
                validator: (value) => PasswordFieldValidator.validate(value!),
                controller: password,
                obscureText: secure,
                decoration: InputDecoration(
                    hintText: "Password",
                    icon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          secure = !secure;
                        });
                      },
                      icon: secure == true
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 80,
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
                  SignIn(context);
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
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("forget_password");
              },
              child: const Text(
                "Forget your password",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 400,
              child: Image(
                image: AssetImage("lib/images/blue.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
