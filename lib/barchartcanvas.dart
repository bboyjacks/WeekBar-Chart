import 'package:flutter/material.dart';
import 'barchartpainter.dart';

class BarChartCanvas extends StatelessWidget {
  BarChartCanvas({
    this.width,
    this.height,
    this.data,
    this.tween
  });

  final double width;
  final double height;
  final List<double> data;
  final Animation<double> tween;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: BarChartPainter(
        data: data,
        tween: tween
      ),
    );
  }
}