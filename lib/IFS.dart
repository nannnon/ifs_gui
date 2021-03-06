import 'dart:math';

class Vector {
  final double x;
  final double y;

  const Vector(this.x, this.y);
}

class IFS {
  List<List<double>> _cofs;
  List<double> _ps;

  double _xn = 0;
  double _yn = 0;
  final _random = Random();

  IFS(this._cofs, this._ps) {
    if (_cofs.isEmpty) {
      throw "Invalid length";
    }

    if (_cofs.length != _ps.length) {
      throw "lengths are different";
    }

    for (var c in _cofs) {
      if (c.length != 6) {
        throw "cof length is not 6";
      }
    }

    for (int i = 1; i < _ps.length; ++i) {
      _ps[i] += _ps[i - 1];
    }

    if (_ps.last < 0.9999 || _ps.last > 1) {
      throw "Invalid ps";
    }
  }

  IFS.fern()
      : this([
          [0, 0, 0, 0, 0.16, 0],
          [0.2, -0.26, 0, 0.23, 0.22, 1.6],
          [-0.15, 0.28, 0, 0.26, 0.24, 0.44],
          [0.85, 0.04, 0, -0.04, 0.85, 1.6]
        ], [
          1 / 100,
          7 / 100,
          7 / 100,
          85 / 100
        ]);

  IFS.ammonite()
      : this([
          [-0.29, 0, 0.59, 0, 0.2, -0.32],
          [-0.07, -0.02, 0.79, -0.01, 0.29, -0.06],
          [0.94, -0.22, -0.05, 0.21, 0.96, 0.01],
        ], [
          0.06,
          0.02,
          0.92
        ]);

  IFS.leaf()
      : this([
          [0.6533, -0.2706, 0, 0.2706, 0.6533, 0],
          [0.6667, 0, 0.3333, 0, -0.6667, 0],
        ], [
          0.5,
          0.5
        ]);

  List<Vector> iterate(int steps) {
    List<Vector> points = [];

    for (int i = 0; i < steps; ++i) {
      final double p = _random.nextDouble();
      int n = -1;
      for (int j = 0; j < _ps.length; ++j) {
        if (p < _ps[j]) {
          n = j;
          break;
        }
      }

      final double x = _xn;
      final double y = _yn;
      _xn = _cofs[n][0] * x + _cofs[n][1] * y + _cofs[n][2];
      _yn = _cofs[n][3] * x + _cofs[n][4] * y + _cofs[n][5];

      points.add(Vector(_xn, _yn));
    }

    return points;
  }
}
