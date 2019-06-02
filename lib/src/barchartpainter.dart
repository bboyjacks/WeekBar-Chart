import 'package:flutter/material.dart';

import 'eventdatavaluenotifier.dart';


class BarChartPainter extends CustomPainter {
  BarChartPainter(
    {
      this.data
    }
  ) : super(repaint: data);
  final EventDataValueNotifier data;

  @override
  void paint(Canvas canvas, Size size) { 
    print("repaint ${data.value}");
  }

  @override
  bool shouldRepaint(BarChartPainter oldPainter) => false;
}