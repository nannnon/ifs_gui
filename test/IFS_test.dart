import 'package:flutter_test/flutter_test.dart';
import 'package:ifs_gui/IFS.dart';

void main() {
  test('IFS test', () {
    var ifs = IFS.shida();
    const int steps = 100;
    var points = ifs.iterate(steps);
    expect(points.length, steps);
  });
}
