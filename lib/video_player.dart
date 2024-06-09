import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VIDEOPLAYER extends StatefulWidget {
  const VIDEOPLAYER({super.key});

  @override
  State<VIDEOPLAYER> createState() => _VIDEOPLAYER();
}

String link = "";

void setLink(String l) {
  link = l;
}

class _VIDEOPLAYER extends State<VIDEOPLAYER> {
  Future<void>? _initializeVideoPlayerFuture;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller with the video URL
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(link),
    );

    // Initialize the video player future
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    // Add a listener to update the UI when the video position changes
    _videoPlayerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              iconSize: 50,
              onPressed: () {
                Navigator.of(context).pushNamed("fitness");
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.blue,
            ),
            const SizedBox(width: 60),
            const Center(
              child: Image(
                image: AssetImage("lib/images/appbar_logo.jpeg"),
                height: 80,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Aspect ratio to maintain the video's aspect ratio
                    AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                    // Video progress indicator with scrubbing enabled
                    VideoProgressIndicator(
                      _videoPlayerController,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.blue,
                        bufferedColor: Colors.lightBlue,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    // Row containing forward and backward controls and the play/pause button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Seek backward 10 seconds
                            final newPosition = _videoPlayerController.value.position - const Duration(seconds: 10);
                            _videoPlayerController.seekTo(newPosition);
                          },
                          icon: const Icon(Icons.replay_10),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_videoPlayerController.value.isPlaying) {
                                _videoPlayerController.pause(); // Pause the video
                              } else {
                                _videoPlayerController.play(); // Play the video
                              }
                            });
                          },
                          icon: Icon(
                            _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Seek forward 10 seconds
                            final newPosition = _videoPlayerController.value.position + const Duration(seconds: 10);
                            _videoPlayerController.seekTo(newPosition);
                          },
                          icon: const Icon(Icons.forward_10),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(), // Show a loading indicator while the video is loading
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause(); // Pause the video
            } else {
              _videoPlayerController.play(); // Play the video
            }
          });
        },
        child: Icon(
          _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow, // Change icon based on playing state
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: const Text("Video Player"),
//       ),
//       body: const VIDEOPLAYER(),
//     ),
//   ));
// }
