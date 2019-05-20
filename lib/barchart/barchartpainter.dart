import 'package:flutter/material.dart';
import '../utils.dart';

class BarChartPainter extends CustomPainter {
  final double width;
  final double height;
  final double padding;
  final double barSpacing;
  BarChartPainter(
    {
      @required this.width, 
      @required this.height,
      this.padding = 10.0,
      this.barSpacing = 0.01
    }
  );

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
        this.padding,
        this.height - this.padding),
      Offset(
        this.width - this.padding, 
        this.height - this.padding),
      Paint()..color = Colors.black
    );
  }

  void paintYAxisLine(Canvas canvas) {
    canvas.drawLine(
      Offset(
        this.padding,
        this.padding
      ),
      Offset(
        this.padding,
        this.height - this.padding
      ),
      Paint()..color = Colors.black
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintXAxisLine(canvas);
    paintYAxisLine(canvas);
    List<double> data = [30.0, 40.0, 50.0, 70.0, 25.0, 50.0, 45];
    var xUnits = getXUnitCoordinates(data);
    var yUnits = getYUnitCoordinates(data);
    var barUnitWidth = getB(data.length);
    var xMin = this.padding;
    var xMax = this.width - this.padding;
    var yMin = this.padding;
    var yMax = this.height - this.padding;

    var barHeights = yUnits.map((y) => 1 - y).toList();

    for (int i = 0; i < xUnits.length; i++) {
      var offSet1 = Offset(
        Utils.map(xUnits[i], 0, 1, xMin, xMax),
        Utils.map(yUnits[i], 0, 1, yMin, yMax)
      );

      var offSet2 = Offset(
        Utils.map(xUnits[i] + barUnitWidth, 0, 1, xMin, xMax),
        Utils.map(yUnits[i] + barHeights[i], 0, 1, yMin, yMax)
      );

      canvas.drawRect(
        Rect.fromPoints(offSet1, offSet2),
        Paint()
          ..color = Colors.red
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}