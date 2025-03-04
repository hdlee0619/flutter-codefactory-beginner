import 'package:flutter/material.dart';

import '/screen/cam_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(children: [_Logo(), _MainImage(), _JoinButton()]),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[300]!,
                blurRadius: 12.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.videocam, color: Colors.white),
                SizedBox(width: 12.0),
                Text(
                  "LIVE",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainImage extends StatelessWidget {
  const _MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(child: Image.asset('assets/images/home_img.png')),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => CamScreen()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: Text('입장하기', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
