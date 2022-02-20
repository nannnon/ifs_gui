import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ifs_gui/IFS.dart';
import 'package:ifs_gui/MyImage.dart';

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
  final IFS _ifs = IFS.shida();
  final MyImage _image = MyImage(512, 1024, Colors.black);
  ui.Image? _imgBuffer;

  @override
  void initState() {
    Timer.periodic(
      const Duration(milliseconds: 100),
      _onTimer,
    );

    super.initState();
  }

  void _onTimer(Timer timer) async {
    const int steps = 50;
    final points = _ifs.iterate(steps);

    for (var point in points) {
      const double scale = 50;
      final int x = (point.x * scale).round() + _image.width ~/ 2;
      final int y =
          _image.height - 1 - (point.y * scale).round() - _image.height ~/ 5;

      _image.setPixel(x, y, Colors.white);
    }

    _imgBuffer = await _image.convertToUIImage();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: RawImage(image: _imgBuffer),
        constrained: false,
      ),
    );
  }
}
