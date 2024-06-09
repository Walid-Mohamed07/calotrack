import 'dart:convert';
import 'package:calo_track/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bottom_bar.dart';
import 'package:http/http.dart' as http;

class MORE extends StatefulWidget {
  const MORE({super.key});

  @override
  State<MORE> createState() => _MOREState();
}

Map userData = {};

getUserData() {
  return userData;
}

class _MOREState extends State<MORE> {
  Future LogOut(BuildContext cont) async {
    String url = "https://caltrack.atwebpages.com/registration/logout.php";
    var response = await http.post(Uri.parse(url), body: {
      "token": getToken(),
    });
    String data = json.decode(response.body);
    if (data == "success") {
      Navigator.of(context).pushNamedAndRemoveUntil("breif", (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "ERROR, TRY AGAIN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    }
  }

  Future UserData(BuildContext cont) async {
    String url = "https://caltrack.atwebpages.com/registration/getUserData.php";
    var response = await http.post(Uri.parse(url), body: {
      "token": getToken(),
    });
    var data = json.decode(response.body);
    if (data != null) {
      setState(() {
        userData = data;
      });
    } else {
      Fluttertoast.showToast(
          msg: "ERROR, TRY AGAIN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      UserData(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BOTTOMBAR(),
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "MORE",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  child: ClipOval(
                    child: Image.network(
                      getUserData()["user_picture"],
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  userData.isNotEmpty
                      ? "${userData["user_name"]}\n${userData["email"]}"
                      : " \n ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("account");
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 60,
                      child: Row(children: [
                        Icon(
                          Icons.person_2_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("My Account"),
                      ])),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("favorite");
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 60,
                      child: Row(children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Favorite"),
                      ])),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 60,
                      child: Row(children: [
                        Icon(
                          Icons.contact_page_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Contact Us\ncalotrack@gmail.com"),
                      ])),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 0,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                userData.clear;
              });
              LogOut(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 60,
                      child: Row(children: [
                        Icon(
                          Icons.logout,
                          size: 50,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Logout"),
                      ])),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
