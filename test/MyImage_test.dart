import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifs_gui/MyImage.dart';

void main() {
  test('MyImage test', () async {
    const int w = 124;
    const int h = 97;
    MyImage img = MyImage(w, h, Colors.black);

    img.fill(Colors.black);
    img.setPixel(10, 12, Colors.red);
    await img.convertToUIImage();
    ui.Image uiimg = await img.convertToUIImage();

    expect(img.width, w);
    expect(img.height, h);
    expect(uiimg.width, w);
    expect(uiimg.height, h);
  });
}
