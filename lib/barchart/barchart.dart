import 'package:flutter/material.dart';
import 'barchartpainter.dart';

class BarChart extends StatelessWidget {
  final double chartWidth = 300.0;
  final double chartHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 2.0
              )
            ),
            child: SizedBox(
              width: this.chartWidth, 
              height: this.chartHeight, 
              child: CustomPaint(
                painter: BarChartPainter(
                  width: this.chartWidth, 
                  height: this.chartHeight,
                  padding: 10.0
                )
              )
            )
        )
    );
  }
}

