import 'package:flutter/material.dart';
import 'barchartcanvas.dart';
import 'utils.dart' as utils;

class BarChart extends StatefulWidget {
  BarChart({this.data});
  final List<double> data;
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> with SingleTickerProviderStateMixin {
  static const canvasWidth = 400.0;
  static const canvasHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: canvasWidth,
        height: canvasHeight,
        child: BarChartCanvas(
          width: canvasWidth,
          height: canvasHeight,
          data: widget.data
        ),
      )
    );
  }
}