import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _show = false;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_show)
              GestureDetector(
                onTap: () {
                  setState(() {
                    color = color == Colors.red ? Colors.blue : Colors.red;
                  });
                },
                child: TestScreen(color: color),
              ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _show = !_show;
                });
              },
              child: Text('클릭해서 보이기/안보이기'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  TestScreen({super.key, required this.color}) {
    print('1) Stateful Widget constructor');
  }

  final Color color;

  @override
  State<TestScreen> createState() {
    print('2) Stateful Widget createState()');

    return _TestScreenState();
  }
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    print('3) Stateful Widget initState()');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4) Stateful Widget didChangeDependencies()');

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TestScreen oldWidget) {
    print('7) Stateful Widget didUpdateWidget()');

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('5) Stateful Widget build()');

    return Container(width: 50.0, height: 50.0, color: widget.color);
  }

  @override
  void deactivate() {
    print('6) Stateful Widget deactivate()');

    super.deactivate();
  }

  @override
  void dispose() {
    print('7) Stateful Widget dispose()');

    super.dispose();
  }
}
