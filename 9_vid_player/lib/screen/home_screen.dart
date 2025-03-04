import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showVideoPlayer = false;
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          video != null
              ? _VideoPlayer(video: video!)
              : _VideoSelector(onTap: handleLogoTap),
    );
  }

  handleLogoTap() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      this.video = video;
    });
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}

class _Title extends StatelessWidget {
  _Title({super.key});

  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: 32.0,
    fontWeight: FontWeight.w300,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("VIDEO", style: textStyle),
        Text("PLAYER", style: textStyle.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;

  const _VideoPlayer({required this.video, super.key});

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  // late는 지금 당장 여기서 초기화하진 않을 건데, VideoPlayer를 사용할 때에는 초기화 할 것이다. 라는 의미
  late final VideoPlayerController videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    initializeController();
  }

  initializeController() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));

    videoPlayerController.addListener(() {
      setState(() {});
    });

    await videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      final currentPosition =
                          videoPlayerController.value.position;

                      Duration position = Duration();

                      if (currentPosition.inSeconds > 3) {
                        position = currentPosition - Duration(seconds: 3);
                      }

                      videoPlayerController.seekTo(position);
                    },
                    icon: Icon(Icons.rotate_left, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (videoPlayerController.value.isPlaying) {
                          videoPlayerController.pause();
                        } else {
                          videoPlayerController.play();
                        }
                      });
                    },
                    icon: Icon(
                      videoPlayerController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final maxPosition = videoPlayerController.value.duration;
                      final currentPosition =
                          videoPlayerController.value.position;

                      Duration position = maxPosition;

                      if ((maxPosition - Duration(seconds: 3)).inSeconds >
                          currentPosition.inSeconds) {
                        position = currentPosition + Duration(seconds: 3);
                      }

                      videoPlayerController.seekTo(position);
                    },
                    icon: Icon(Icons.rotate_right, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Slider(
                value:
                    videoPlayerController.value.position.inSeconds.toDouble(),
                max: videoPlayerController.value.duration.inSeconds.toDouble(),
                onChanged: (double value) {},
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.photo_camera_back, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    super.dispose();
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onTap;

  const _VideoSelector({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2A3A7C), Color(0xFF000118)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_Logo(onTap: onTap), SizedBox(height: 24.0), _Title()],
      ),
    );
  }
}
