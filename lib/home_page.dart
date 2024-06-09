import 'dart:convert';
import 'package:calo_track/bottom_bar.dart';
import 'package:calo_track/favorite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'sign_in.dart';

class HOMEPAGE extends StatefulWidget {
  const HOMEPAGE({super.key});

  @override
  State<HOMEPAGE> createState() => _HOMEPAGEState();
}

String itemDetails = "";
double item_p = 0;
double item_c = 0;
double item_f = 0;
double item_cal = 0;
Color c = Colors.grey;

class _HOMEPAGEState extends State<HOMEPAGE> {
  final TextEditingController searchValue = TextEditingController();
  List items = [];
  List searchedItems = [];
  List<bool> isf = [];

  ItemsList() async {
    var response = await http.post(
      Uri.parse("https://caltrack.atwebpages.com/CRUD/items/getAll.php"),
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data != null) {
      setState(() {
        items = data;
      });
    }
    _updateIsfList();
  }

  Future likeItem(BuildContext cont, String name) async {
    String url =
        "https://caltrack.atwebpages.com/CRUD/favorite/favoriteItem.php";
    await http.post(Uri.parse(url), body: {
      "token": getToken(),
      "itemName": name,
    });
  }

  void _updateIsfList() {
    setState(() {
      isf = List<bool>.filled(items.length, false);
      for (var item in items) {
        for (var likeditem in likedItems) {
          if (mapEquals(item, likeditem)) {
            isf[items.indexOf(item)] = true;
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    ItemsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BOTTOMBAR(),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("lib/images/appbar_logo.jpeg"),
              height: 80,
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              padding: const EdgeInsets.only(
                left: 5,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: TextFormField(
                key: const Key("searchvalue"),
                keyboardType: TextInputType.text,
                controller: searchValue,
                decoration: const InputDecoration(
                  hintText: "Search for food",
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  searchedItems.clear();
                  for (var element in items) {
                    if (element["name"].toLowerCase().contains(
                          value.toLowerCase(),
                        )) {
                      setState(() {
                        searchedItems.add(element);
                      });
                      if (searchedItems.length >= 5) break;
                    }
                  }
                },
                onTapOutside: (event) {
                  searchedItems.clear();
                },
              ),
            ),
            for (var item
                in (searchedItems.isEmpty ? items.take(5) : searchedItems))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        base64.decode(item["image"]),
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(item["name"]),
                  subtitle: Text(
                    "${item["calories"]}  cal",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    color: isf.length >= items.length
                        ? isf[items.indexOf(item)]
                            ? Colors.blue
                            : Colors.grey
                        : Colors.grey,
                    onPressed: () {
                      setState(() {
                        likedItems.add(item);
                        likeItem(context, item["name"]);
                        isf[items.indexOf(item)] = true;
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      itemDetails = item["name"];
                      item_p = double.parse(item["proteins"]);
                      item_c = double.parse(item["carbs"]);
                      item_f = double.parse(item["fat"]);
                      item_cal = double.parse(item["calories"]);
                      Navigator.of(context).pushNamed("itemDetails");
                    });
                  },
                ),
              ),
          ],
        ),
      ]),
    );
  }
}
