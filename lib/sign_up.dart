import 'package:calo_track/sign_up_page_2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NameFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Name Field can\'t be empty" : null;
  }
}

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

class SIGNUP extends StatefulWidget {
  const SIGNUP({super.key});

  @override
  State<SIGNUP> createState() => _Signupstate();
}

class _Signupstate extends State<SIGNUP> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future SignUp(BuildContext cont) async {
    if (name.text == "" || email.text == "" || password.text == "") {
      Fluttertoast.showToast(
        msg: "The name or email or password fields can't be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
    } else {
      setName(name.text);
      setemail(email.text);
      setpassword(password.text);
      Navigator.of(context).pushNamed("sign_up2");
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
              height: 120,
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
                  key: const Key("name"),
                  validator: (value) => NameFieldValidator.validate(value!),
                  keyboardType: TextInputType.text,
                  controller: name,
                  decoration: const InputDecoration(
                      hintText: "Full Name",
                      icon: Icon(Icons.person),
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
              height: 50,
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
              height: 100,
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
                  SignUp(context);
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: const Text(
                      "NEXT",
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
