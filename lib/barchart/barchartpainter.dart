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

  List<double> getXCoordinates(n) {
    List<double> result = [];
    var barWidth = getB(n);
    for (int i = 0; i < n; i++) {
      double vStart = this.barSpacing * (i + 1) + barWidth * i;
      double vEnd = vStart + barWidth;
      result.add(vStart);
      result.add(vEnd);
    }

    List<double> scaledResult = [];
    result.forEach((x){
      scaledResult.add(Utils.map(x, 0, 1, this.padding, this.width - this.padding));
    });
    return scaledResult;
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

    List<double> result = getXCoordinates(31);
    for (int i = 0; i < result.length - 1; i += 2) {
      var start = Offset(result[i], this.height - this.padding);
      var end = Offset(result[i+1], this.height - this.padding);
      var paint = Paint()
                  ..color = Colors.red
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5.0;
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}