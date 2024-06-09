import 'package:calo_track/bottom_bar.dart';
import 'package:calo_track/video_player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FITNESS extends StatefulWidget {
  const FITNESS({super.key});

  @override
  State<FITNESS> createState() => _FITNESSState();
}

class _FITNESSState extends State<FITNESS> {
  List videos = [];

  VideoList() async {
    var response = await http.post(
      Uri.parse(
          "https://caltrack.atwebpages.com/CRUD/fitnessVideos/getAll.php"),
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data != null) {
      setState(() {
        videos = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    VideoList();
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
        title: const Center(
          child: Image(
            image: AssetImage("lib/images/appbar_logo.jpeg"),
            height: 80,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          for (var video in videos)
            InkWell(
              onTap: () {
                setState(
                  () {
                    setLink(video["video"]);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("video", (route) => false);
                  },
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(
                      base64.decode(video["image"]),
                      height: 90,
                      width: 90,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      video["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
