import 'package:flutter/material.dart';
import 'utils.dart';

class BarChartPainter extends CustomPainter {
  BarChartPainter(
    {
      this.data,
      this.colors,
      this.max,
    }
  );
  final double _barGap = 0.01;
  final double max;
  final List<double> data;
  final List<String> colors;

  double get _barWidth {
    int n = data.length;
    return (1 - _barGap * (n + 1)) / n;
  }

  List<double> get _starts {
    List<double> starts = [];
    double barWidth = _barWidth;
    double currentStart = _barGap;
    while(currentStart + barWidth < 1) {
      starts.add(currentStart);
      currentStart += barWidth + _barGap;
    }
    return starts;
  }


  void _paintLines(Canvas canvas, Size size) {
    for (int i = 1; i <= 10; i += 2) {
      double y = map(1 - i * 0.1, 0, 1, 0, size.height);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y), 
        Paint()..color = Colors.black
      );
    }
  }

  void _paintBars(Canvas canvas, Size size) {
    List<double> starts = _starts;
    double barWidth = _barWidth;
    for (int i = 0; i < data.length; i++) {
      double unitData = map(data[i], 0, max, 0, 1);
      double startX = map(starts[i], 0, 1, 0, size.width);
      double startY = map(1, 0, 1, 0, size.height);
      double endX = map(starts[i] + barWidth, 0, 1, 0, size.width);
      double endY = map(1 - unitData, 0, 1, 0, size.height);
      canvas.drawRect(
        Rect.fromPoints(
          Offset(startX, startY), 
          Offset(endX, endY)
        ),
        Paint()..color = HexColor(colors[i])
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintLines(canvas, size);
    _paintBars(canvas, size);
  }

  @override
  bool shouldRepaint(BarChartPainter oldPainter) => false;
}

class EmptyBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}