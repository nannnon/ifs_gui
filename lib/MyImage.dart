import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';

class MyImage {
  final int _width;
  final int _height;
  final Uint8List _pixels;

  MyImage(this._width, this._height, Color color)
      : _pixels = Uint8List(_width * _height * 4) {
    fill(color);
  }

  void fill(Color color) {
    for (int x = 0; x < _width; ++x) {
      for (int y = 0; y < _height; ++y) {
        setPixel(x, y, color);
      }
    }
  }

  void setPixel(int x, int y, Color color) {
    if (x < 0 || x >= _width || y < 0 || y >= _height) {
      return;
    }

    int index = (y * _width + x) * 4;
    _pixels[index + 0] = color.red;
    _pixels[index + 1] = color.green;
    _pixels[index + 2] = color.blue;
    _pixels[index + 3] = color.alpha;
  }

  Future<ui.Image> convertToUIImage() async {
    Completer<ui.Image> c = Completer();
    ui.decodeImageFromPixels(_pixels, _width, _height, ui.PixelFormat.rgba8888,
        (ui.Image result) {
      c.complete(result);
    });
    return c.future;
  }
}
