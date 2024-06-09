import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class BOTTOMBAR extends StatefulWidget {
  const BOTTOMBAR({super.key});

  @override
  State<BOTTOMBAR> createState() => _BOTTOMBARState();
}

class _BOTTOMBARState extends State<BOTTOMBAR> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: activePage,
      height: 60.0,
      items: const [
        CurvedNavigationBarItem(
          child: Icon(Icons.home, size: 30, color: Colors.black),
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.list_alt, size: 30, color: Colors.black),
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.fitness_center, size: 30, color: Colors.black),
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.more_vert, size: 30, color: Colors.black),
        ),
      ],
      color: Colors.grey.shade300,
      buttonBackgroundColor: Colors.grey.shade300,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        Future.delayed(
          const Duration(milliseconds: 650),
          () {
            if (index == 0) {
              if (activePage != 0) {
                Navigator.of(context).pushNamed("home_page");
                setState(() {
                  activePage = index;
                });
              }
            } else if (index == 1) {
              if (activePage != 1) {
                Navigator.of(context).pushNamed("recipes");
                setState(() {
                  activePage = index;
                });
              }
            } else if (index == 2) {
              if (activePage != 2) {
                Navigator.of(context).pushNamed("fitness");
                setState(() {
                  activePage = index;
                });
              }
            } else if (index == 3) {
              if (activePage != 3) {
                Navigator.of(context).pushNamed("more");
                setState(() {
                  activePage = index;
                });
              }
            }
          },
        );
      },
      letIndexChange: (index) => true,
    );
  }
}
