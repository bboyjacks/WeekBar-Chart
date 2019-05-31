import 'package:flutter/material.dart';
import 'utils.dart' as utils;

class UnitBar {
  UnitBar(this.n, this.unitGap);
  final double n;
  final double unitGap;

  double get width {
    return ((1 - unitGap * (n + 1)) / n);
  }
}

double getMax(List<double> data) {
  double result = - double.infinity;
  data.forEach((item){
    if (result < item) {
      result = item;
    }
  });
  return result;
}

class BarChartPainter extends CustomPainter {

  BarChartPainter({
    this.data,
    Animation<double> tween
  }) : tween = tween, super(repaint: tween);
  final List<double> data;
  final double gap = 0.1;
  Animation<double> tween;
 
  double lerp(double min, double max, double percent) {
    return (max - min) * percent;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double barWidth = UnitBar(data.length.toDouble(), gap).width;
    double unitX = 0.0;
    double maxVal = getMax(data);
    for (int i = 0; i < data.length; i++) {
      double unitY = utils.map(data[i], 0, maxVal, 0, 1) * tween.value;
      unitX = gap + ((barWidth + gap) * i);
      double startX = utils.map(unitX, 0, 1, 0, size.width);
      double startY = utils.map(1, 0, 1, 0, size.height);
      double endX = utils.map(unitX + barWidth, 0, 1, 0, size.width);
      double endY = utils.map(1 - unitY, 0, 1, 0, size.height);
      canvas.drawRect(
        Rect.fromPoints(Offset(startX, startY), Offset(endX, endY)),
        Paint()..color = Colors.red
      );
    }
  }

  @override
  bool shouldRepaint(BarChartPainter oldPainter) => false;
}