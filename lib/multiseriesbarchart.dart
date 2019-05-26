import 'package:flutter/material.dart';
import 'dataseries.dart';
import 'multiseriesbarchartpainter.dart';

class MultiSeriesBarChart extends StatefulWidget {
  MultiSeriesBarChart({this.dataSeries});
  final List<DataSeries> dataSeries;
  final double width = 300.0;
  final double height = 200.0;

  @override
  _MultiSeriesBarChartState createState() => _MultiSeriesBarChartState();
}

class _MultiSeriesBarChartState extends State<MultiSeriesBarChart> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: widget.width,
        child: CustomPaint(
          painter: MultiSeriesBarChartPainter(),
          size: Size(widget.width, widget.height),
        )
      )
    );
  }
}