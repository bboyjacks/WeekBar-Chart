import 'package:flutter/material.dart';
import 'multiseriesbarchartpainter.dart';
import 'dataseries.dart';

class MultiSeriesBarChartCanvas extends StatelessWidget {
  MultiSeriesBarChartCanvas(
    {
      this.width,
      this.height,
      this.animation,
      this.dataSeriesList
    }
  );
  final double width;
  final double height;
  final Animation<double> animation;
  final List<DataSeries> dataSeriesList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SizedBox(
        width: width,
        child: CustomPaint(
          painter: MultiSeriesBarChartPainter(
            animation,
            unitDataSeries: dataSeriesList
          ),
          size: Size(width, height),
        )
      )
    );
  }
}