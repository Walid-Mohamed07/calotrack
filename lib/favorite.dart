import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';
import 'recipes.dart';
import 'sign_in.dart';

class FAVORITE extends StatefulWidget {
  const FAVORITE({super.key});

  @override
  State<FAVORITE> createState() => _FAVORITE();
}

List likedItems = [];
List likedRecipes = [];

class _FAVORITE extends State<FAVORITE> {
  Future getFavorite(BuildContext cont) async {
    String url =
        "https://caltrack.atwebpages.com/CRUD/favorite/getAllItems.php";
    var response = await http.post(Uri.parse(url), body: {
      "token": getToken(),
    });
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data != null) {
      setState(() {
        likedItems = data;
      });
    }
    String url2 =
        "https://caltrack.atwebpages.com/CRUD/favorite/getAllRecipes.php";
    var response2 = await http.post(Uri.parse(url2), body: {
      "token": getToken(),
    });
    var data2 = json.decode(utf8.decode(response2.bodyBytes));
    if (data != null) {
      setState(() {
        likedRecipes = data2;
      });
    }
  }

  Future unlikeItem(BuildContext cont, int id) async {
    String url = "https://caltrack.atwebpages.com/CRUD/favorite/unlikeItem.php";
    await http.post(Uri.parse(url), body: {
      "token": getToken(),
      "itemId": "$id",
    });
  }

  Future unlikeRecipe(BuildContext cont, int id) async {
    String url =
        "https://caltrack.atwebpages.com/CRUD/favorite/unlikeRecipe.php";
    await http.post(Uri.parse(url), body: {
      "token": getToken(),
      "recipeId": "$id",
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getFavorite(context);
    });
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
        title: const Text(
          "Favorite",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
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
            for (var item in likedItems)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
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
                  contentPadding: const EdgeInsets.all(5),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(
                      base64.decode(item["image"]),
                      height: 70,
                      width: 70,
                    ),
                  ),
                  title: Text(item["name"]),
                  subtitle: Text(
                    "${item["calories"]} cal",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        likedItems.remove(item);
                        unlikeItem(context, item["id"]);
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                    ),
                  ),
                ),
              ),
            for (var recipe in likedRecipes)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
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
                    });
                  },
                  contentPadding: const EdgeInsets.all(5),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(
                      base64.decode(recipe["image"]),
                      height: 120,
                    ),
                  ),
                  title: Text(recipe["name"]),
                  subtitle: Text(
                    "${recipe["calories"]} cal",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        likedRecipes.remove(recipe);
                        unlikeRecipe(context, recipe["id"]);
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
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
