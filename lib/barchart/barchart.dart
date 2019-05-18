import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: SizedBox(
          width: 100.0, 
          height: 100.0, 
          child: CustomPaint()
        )
      );
  }
}

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, 100, 100),
      Paint()..color = Colors.black
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}
