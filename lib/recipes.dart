import 'package:calo_track/bottom_bar.dart';
import 'package:calo_track/favorite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'sign_in.dart';

class RECIPES extends StatefulWidget {
  const RECIPES({super.key});

  @override
  State<RECIPES> createState() => _RECIPESState();
}

String recipeDetails = "";
String prep_time = "";
String cook_time = "";
String total_time = "";
String ingredients = "";
String steps = "";
double recipe_p = 0;
double recipe_c = 0;
double recipe_f = 0;
double recipe_cal = 0;
String image = "";

class _RECIPESState extends State<RECIPES> {
  final TextEditingController searchValue = TextEditingController();
  List recipes = [];
  List searchedRecipe = [];
  List<bool> isf = [];

  recipesList() async {
    var response = await http.post(
      Uri.parse("https://caltrack.atwebpages.com/CRUD/recipes/getAll.php"),
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data != null) {
      setState(() {
        recipes = data;
      });
    }
    setState(() {
      for (var recipe in searchedRecipe.isEmpty ? recipes : searchedRecipe) {
        isf.add(false);
        for (var likedrecipe in likedRecipes) {
          if (mapEquals(recipe, likedrecipe)) {
            isf[recipes.indexOf(recipe)] = true;
          }
        }
      }
    });
  }

  Future likerecipe(BuildContext cont, String name) async {
    String url =
        "https://caltrack.atwebpages.com/CRUD/favorite/favoriteRecipe.php";
    await http.post(Uri.parse(url), body: {
      "token": getToken(),
      "recipeName": name,
    });
  }

  @override
  void initState() {
    super.initState();
    recipesList();
    isf.clear();
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
      body: SingleChildScrollView(
        child: Column(
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
                  hintText: "Search",
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  searchedRecipe.clear();
                  for (var element in recipes) {
                    if (element["name"].toLowerCase().contains(
                          value.toLowerCase(),
                        )) {
                      setState(() {
                        searchedRecipe.add(element);
                      });
                    }
                  }
                },
                onTapOutside: (event) {
                  searchedRecipe.clear();
                },
              ),
            ),
            SizedBox(
              height: 485,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  for (var recipe
                      in searchedRecipe.isEmpty ? recipes : searchedRecipe)
                    InkWell(
                      onTap: () {
                        setState(() {
                          recipeDetails = recipe["name"];
                          prep_time = recipe["prep_time"];
                          cook_time = recipe["cook_time"];
                          total_time = recipe["total_time"];
                          ingredients = recipe["ingredients"];
                          steps = recipe["Steps"];
                          recipe_p = double.parse(recipe["protein"]);
                          recipe_c = double.parse(recipe["carbs"]);
                          recipe_f = double.parse(recipe["fat"]);
                          recipe_cal = recipe["calories"] * 1.0;
                          Navigator.of(context).pushNamed("recipeDetails");
                          image = recipe["image"];
                        });
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image.memory(
                                    base64.decode(recipe["image"]),
                                    height: 120,
                                    // width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      recipe["name"],
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  color: isf.length >= recipes.length
                                      ? isf[recipes.indexOf(recipe)]
                                          ? Colors.blue
                                          : Colors.grey
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      likedRecipes.add(recipe);
                                      likerecipe(context, recipe["name"]);
                                      isf[recipes.indexOf(recipe)] = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
