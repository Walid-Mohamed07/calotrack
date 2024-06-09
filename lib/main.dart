import 'dart:io';
import 'package:calo_track/account.dart';
import 'package:calo_track/favorite.dart';
import 'package:calo_track/fitness_videos.dart';
import 'package:calo_track/itemDetails.dart';
import 'package:calo_track/more.dart';
import 'package:calo_track/recipeDetails.dart';
import 'package:calo_track/recipes.dart';
import 'package:calo_track/sign_up.dart';
import 'package:calo_track/sign_up_page_2.dart';
import 'package:flutter/material.dart';
import '1200_meal_plan.dart';
import '2000_meal_plan.dart';
import '3000_meal_plan.dart';
import 'breif_page.dart';
import 'forget_password.dart';
import 'home_page.dart';
import 'sign_in.dart';
import 'start_page.dart';
import 'video_player.dart';

Future main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

int activePage = 0;
// الصفحة التي يتم تشغيل البرنامج منها

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // textTheme: Theme.of(context).textTheme.apply(
        //       fontSizeFactor: 1.3,
        //       fontFamily: "Caveat",
        //     ),
      ),
      home: const StartPage(),
      routes: {
        "start": (context) => const StartPage(),
        "breif": (context) => const breif(),
        "sign_in": (context) => const SIGNIN(),
        "sign_up": (context) => const SIGNUP(),
        "sign_up2": (context) => const SIGNUP2(),
        "forget_password": (context) => const FORGETPASSWORD(),
        "home_page": (context) => const HOMEPAGE(),
        "itemDetails": (context) => const ITEMDETAILS(),
        "1200_meal_plan": (context) => const MEALPLAN(),
        "2000_meal_plan": (context) => const MEALPLAN2(),
        "3000_meal_plan": (context) => const MEALPLAN3(),
        "recipes": (context) => const RECIPES(),
        "recipeDetails": (context) => const RECIPEDETAILS(),
        "fitness": (context) => const FITNESS(),
        "video": (context) => const VIDEOPLAYER(),
        "more": (context) => const MORE(),
        "favorite": (context) => const FAVORITE(),
        "account": (context) => const ACCOUNT(),
      },
    );
  }
}
