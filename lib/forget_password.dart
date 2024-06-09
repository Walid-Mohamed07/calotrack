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

class FORGETPASSWORD extends StatefulWidget {
  const FORGETPASSWORD({super.key});

  @override
  State<FORGETPASSWORD> createState() => _FORGETPASSWORD();
}

class _FORGETPASSWORD extends State<FORGETPASSWORD> {
  final TextEditingController email = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  Future ForgetPassword(BuildContext cont) async {
    if (email.text == "" || newPassword.text == "") {
      Fluttertoast.showToast(
        msg: "The email or the new password field can't be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
    } else {
      String url =
          "https://caltrack.atwebpages.com/registration/forget_Password.php";
      var response = await http.post(Uri.parse(url),
          body: {"email": email.text, "password": newPassword.text});
      String data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
      if (data == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("breif", (route) => false);
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
        scrolledUnderElevation: 0,
        toolbarHeight: 90,
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
              width: 20,
            ),
            const Center(
              child: Text(
                "Forget Password",
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
                controller: newPassword,
                obscureText: secure,
                decoration: InputDecoration(
                    hintText: "New Password",
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
                  ForgetPassword(context);
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: const Text(
                      "UPDATE PASSWORD",
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 75,
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
