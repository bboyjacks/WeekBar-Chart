import 'package:flutter/material.dart';
import 'dataseries.dart';
import 'utils.dart';

class MultiSeriesBarChartPainter extends CustomPainter {
  MultiSeriesBarChartPainter(Animation<double> animation, {
    this.unitDataSeries,
  }) : animation = animation, super(repaint: animation);
  final Animation<double> animation;
  final List<DataSeries> unitDataSeries;
  
  @override
  void paint(Canvas canvas, Size size) {
    List<double> mondays = [];
    List<double> tuesdays = [];
    List<double> wednesdays = [];
    List<double> thursdays = [];
    List<double> fridays = [];
    List<double> saturdays = [];
    List<double> sundays = [];

    unitDataSeries.forEach((dataSeries){
      mondays.add(dataSeries.m * animation.value);
      tuesdays.add(dataSeries.t * animation.value);
      wednesdays.add(dataSeries.w * animation.value);
      thursdays.add(dataSeries.th * animation.value);
      fridays.add(dataSeries.f * animation.value);
      saturdays.add(dataSeries.s * animation.value);
      sundays.add(dataSeries.sd * animation.value);
    });

    SeriesColumnPainter mondaySeriesPainter = SeriesColumnPainter(unitSeries: mondays);
    SeriesColumnPainter tuesdaySeriesPainter = SeriesColumnPainter(unitSeries: tuesdays);
    SeriesColumnPainter wednesdaySeriesPainter = SeriesColumnPainter(unitSeries: wednesdays);
    SeriesColumnPainter thursdaySeriesPainter = SeriesColumnPainter(unitSeries: thursdays);
    SeriesColumnPainter fridaySeriesPainter = SeriesColumnPainter(unitSeries: fridays);
    SeriesColumnPainter saturdaySeriesPainter = SeriesColumnPainter(unitSeries: saturdays);
    SeriesColumnPainter sundaySeriesPainter = SeriesColumnPainter(unitSeries: sundays);

    mondaySeriesPainter.paint(canvas, 10);
    tuesdaySeriesPainter.paint(canvas, 70);
    wednesdaySeriesPainter.paint(canvas, 130);
    thursdaySeriesPainter.paint(canvas, 190);
    fridaySeriesPainter.paint(canvas, 250);
    saturdaySeriesPainter.paint(canvas, 310);
    sundaySeriesPainter.paint(canvas, 370);
  }

  @override
  bool shouldRepaint(MultiSeriesBarChartPainter oldPainter) => false;
}

class SeriesColumnPainter {
  final List<Color> colors = [
    Colors.blueAccent, 
    Colors.amberAccent, 
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.greenAccent,
    Colors.indigoAccent,
    Colors.limeAccent,
    Colors.pinkAccent,
    Colors.redAccent,
    Colors.yellowAccent
  ];

  final double width = 50.0;
  final double height = 200.0;

  final List<double> unitSeries;
  SeriesColumnPainter(
    {
      this.unitSeries
    }
  );

  void paint(Canvas canvas, double offSet) {
    final int n = unitSeries.length;
    final double barWidth = width / n;
    for (int i = 0; i < n; i++) {
      double startX = barWidth * i + offSet;
      double startY = map(1 - unitSeries[i], 0, 1, 0, height);
      double endX = barWidth * (i + 1) + offSet;
      double endY = height;
      canvas.drawRect(
        Rect.fromPoints(Offset(startX, startY), Offset(endX, endY)), 
        Paint()..color = colors[i]
      );
    }
  }
}