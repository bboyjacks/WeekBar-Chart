import 'package:flutter/material.dart';
import 'minmaxrange.dart';
import '../utils.dart';

class BarChartPainter extends CustomPainter {
  final double barSpacing;
  final Color color;
  final List<double> data;
  final double height;
  final List<String> xLabels;
  final double padding;
  final double width;
  List<double> xUnits;
  List<double> yUnits;
  double barUnitWidth;
  MinMaxRange minMaxRange;

  BarChartPainter(
    {
      
      @required this.data,
      @required this.xLabels,
      @required this.width, 
      @required this.height,
      this.barSpacing = 0.03,
      this.color = Colors.red,
      this.padding = 10.0,
    }
  ) {
    assert(this.data.length == this.xLabels.length);
    this.xLabels.forEach((label){
      assert(label.length < 15);
    });
    this.minMaxRange = MinMaxRange(
      height: this.height, 
      width: this.width,
      xLabelExist: true,
      yLabelExist: true
      );

    this.xUnits = getXUnitCoordinates(this.data);
    this.yUnits = getYUnitCoordinates(this.data);
    this.barUnitWidth = getB(this.data.length);
  }

  // Calculates proper bar unit width based on n
  double getB(n) {
    if (n == 0)
      return 0;
    return (1 - (n + 1) * this.barSpacing) / n;
  }

  List<double> getXUnitCoordinates(data) {
    var n = data.length;
    List<double> result = [];
    var barWidth = getB(n);
    for (int i = 0; i < n; i++) {
      double vStart = this.barSpacing * (i + 1) + barWidth * i;
      result.add(vStart);
    }
    return result;
  }

  List<double> getYUnitCoordinates(data) {
    List<double> result = [];
    double maxData = Utils.max(data);
    data.forEach((y){
      result.add(1 - Utils.map(y, 0, maxData, 0, 1));
    });
    return result;
  }


  /*
  * Drawing related methods
  */
  void paintXAxisLine(Canvas canvas) {
    canvas.drawLine(
      Offset(
        this.minMaxRange.origin["x"],
        this.minMaxRange.origin["y"]),
      Offset(
        this.minMaxRange.xMax["x"], 
        this.minMaxRange.xMax["y"]),
      Paint()..color = Colors.black
    );
  }

  void paintYAxisLine(Canvas canvas) {
    canvas.drawLine(
      Offset(
        this.minMaxRange.yMax["x"],
        this.minMaxRange.yMax["y"]
      ),
      Offset(
        this.minMaxRange.origin["x"],
        this.minMaxRange.origin["y"]
      ),
      Paint()..color = Colors.black
    );
  }

  void paintBars(Canvas canvas) {


    var barHeights = yUnits.map((y) => 1 - y).toList();

    for (int i = 0; i < xUnits.length; i++) {
      var offSet1 = Offset(
        Utils.map(this.xUnits[i], 0, 1, this.minMaxRange.origin["x"], this.minMaxRange.xMax["x"]),
        Utils.map(this.yUnits[i], 0, 1, this.minMaxRange.yMax["y"], this.minMaxRange.origin["y"])
      );

      var offSet2 = Offset(
        Utils.map(this.xUnits[i] + this.barUnitWidth, 0, 1, this.minMaxRange.origin["x"], this.minMaxRange.xMax["x"]),
        Utils.map(this.yUnits[i] + barHeights[i], 0, 1, this.minMaxRange.yMax["y"], this.minMaxRange.origin["y"])
      );

      canvas.drawRect(
        Rect.fromPoints(offSet1, offSet2),
        Paint()
          ..color = this.color
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintXAxisLine(canvas);
    paintYAxisLine(canvas);
    paintBars(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}