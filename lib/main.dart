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

enum IFSType { fern, ammonite, leaf }

class _MyHomePageState extends State<MyHomePage> {
  IFS _ifs = IFS.fern();
  double _scale = 50;
  int _steps = 50;
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
    final points = _ifs.iterate(_steps);

    for (var point in points) {
      final int x = (point.x * _scale).round() + _image.width ~/ 2;
      final int y =
          _image.height - 1 - (point.y * _scale).round() - _image.height ~/ 2;

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
      floatingActionButton: DropdownButton(
        value: IFSType.fern,
        items: const [
          DropdownMenuItem(child: Text('シダ'), value: IFSType.fern),
          DropdownMenuItem(child: Text('アンモナイト'), value: IFSType.ammonite),
          DropdownMenuItem(child: Text('葉飾り'), value: IFSType.leaf),
        ],
        onChanged: (IFSType? value) {
          setState(() {
            _image.fill(Colors.black);
            switch (value) {
              case IFSType.fern:
                _ifs = IFS.fern();
                _scale = 50;
                _steps = 50;
                break;
              case IFSType.ammonite:
                _ifs = IFS.ammonite();
                _scale = 300;
                _steps = 200;
                break;
              case IFSType.leaf:
                _ifs = IFS.leaf();
                _scale = 300;
                _steps = 200;
                break;
              case null:
                break;
            }
          });
        },
        icon: const Icon(Icons.update),
        iconSize: 48,
      ),
    );
  }
}
