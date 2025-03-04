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
              ? _VideoPlayer(video: video!, onAnotherVideoTap: handleLogoTap)
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
  final VoidCallback onAnotherVideoTap;

  const _VideoPlayer({
    required this.video,
    required this.onAnotherVideoTap,
    super.key,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  // late는 지금 당장 여기서 초기화하진 않을 건데, VideoPlayer를 사용할 때에는 초기화 할 것이다. 라는 의미
  late VideoPlayerController videoPlayerController;
  bool showVideoController = true;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    initializeController();
  }

  @override
  void didUpdateWidget(covariant _VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      videoPlayerController.dispose();
      initializeController();
    }
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
    return GestureDetector(
      onTap: () {
        setState(() {
          showVideoController = !showVideoController;
        });
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController),
              if (showVideoController)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              if (showVideoController)
                _PlayButtons(
                  onReversePressed: handleReverse,
                  onPlayPressed: handlePlay,
                  onForwardPressed: handleForward,
                  isPlaying: videoPlayerController.value.isPlaying,
                ),
              if (showVideoController)
                _VideoSlider(
                  position: videoPlayerController.value.position,
                  maxPosition: videoPlayerController.value.duration,
                  onSliderChanged: handleSliderChanged,
                ),
              if (showVideoController)
                _AnotherVideo(onTap: widget.onAnotherVideoTap),
            ],
          ),
        ),
      ),
    );
  }

  handleReverse() {
    final currentPosition = videoPlayerController.value.position;

    Duration position = Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }

  handlePlay() {
    setState(() {
      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
      } else {
        videoPlayerController.play();
      }
    });
  }

  handleForward() {
    final maxPosition = videoPlayerController.value.duration;
    final currentPosition = videoPlayerController.value.position;

    Duration position = maxPosition;

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }

  handleSliderChanged(double value) {
    final position = Duration(seconds: value.toInt());

    videoPlayerController.seekTo(position);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    super.dispose();
  }
}

class _PlayButtons extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _PlayButtons({
    required this.onReversePressed,
    required this.onPlayPressed,
    required this.onForwardPressed,
    required this.isPlaying,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onReversePressed,
            icon: Icon(Icons.rotate_left, color: Colors.white),
          ),
          IconButton(
            onPressed: onPlayPressed,
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: onForwardPressed,
            icon: Icon(Icons.rotate_right, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _VideoSlider extends StatelessWidget {
  final Duration position;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _VideoSlider({
    required this.position,
    required this.maxPosition,
    required this.onSliderChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Slider(
                value: position.inSeconds.toDouble(),
                max: maxPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
              ),
            ),
            Text(
              '${maxPosition.inMinutes.toString().padLeft(2, '0')}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnotherVideo extends StatelessWidget {
  final VoidCallback onTap;

  const _AnotherVideo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(Icons.photo_camera_back, color: Colors.white),
      ),
    );
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
