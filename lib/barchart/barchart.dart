import 'package:flutter/material.dart';
import 'barchartpainter.dart';

class BarChart extends StatefulWidget {
  final double chartHeight;
  double chartWidth;
  final List<double> data;
  final List<String> xLabels;
  BarChart({
    this.chartHeight = 200.0,
    this.chartWidth = 0.0,
    this.data,
    this.xLabels
  }) {
    assert(this.data.length > 0);
    assert(this.data.length == this.xLabels.length);
  }

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.chartWidth == 0.0) {
      widget.chartWidth = MediaQuery.of(context).size.width;
    }
    return FittedBox(
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 1.0
              )
            ),
            child: SizedBox(
              width: widget.chartWidth,
              height: widget.chartHeight,
              child: CustomPaint(
                painter: BarChartPainter(
                  width: widget.chartWidth,
                  height: widget.chartHeight,
                  data: widget.data,
                  xLabels: widget.xLabels,
                ),
              )
            ),
      )
    );
  }
}

