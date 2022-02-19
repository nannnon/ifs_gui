import 'package:flutter/material.dart';
import 'package:ifs_gui/IFS.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IFS _ifs = IFS.shida();
  final List<Vector> _points = [];

  @override
  void initState() {
    Timer.periodic(
      const Duration(milliseconds: 10),
      _onTimer,
    );
    super.initState();
  }

  void _onTimer(Timer timer) {
    const int steps = 10;
    setState(() => _points.addAll(_ifs.iterate(steps)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: Size.infinite,
        painter: MyPainter(_points),
      ),
      //floatingActionButton: const FloatingActionButton(
      //  onPressed: null,
      //  tooltip: 'Increment',
      //  child: Icon(Icons.add),
      //),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Vector> _points;

  const MyPainter(this._points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;

    for (var point in _points) {
      const int scale = 10;
      final double x = point.x * scale + size.width / 2;
      final double y = size.height - 1 - point.y * scale - size.height / 2;
      canvas.drawRect(Rect.fromLTWH(x, y, 1, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
