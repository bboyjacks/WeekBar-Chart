import 'package:flutter/material.dart';
import 'utils.dart';
import 'eventdata.dart';

double maxBarData(List<BarData> data) {
  double max = -double.infinity;
  data.forEach((item) {
    if (max < item.numEvents) {
      max = item.numEvents;
    }
  });
  return max;
}

class BarChartPainter extends CustomPainter {
  BarChartPainter(
    {
      this.data
    }
  );
  final List<EventData> data;
  final double _barGap = 0.01;

  double get _barWidth {
    int n = data.length;
    return (1 - _barGap * (n + 1)) / n;
  }

  List<double> get _starts {
    List<double> starts = [];
    double barWidth = _barWidth;
    double currentStart = _barGap;
    while(currentStart + barWidth < 1) {
      starts.add(currentStart);
      currentStart += barWidth + _barGap;
    }
    return starts;
  }

  List<BarData> get _series {
    List<BarData> result = [];
    data.forEach((eventData) {
      result.add(BarData(
        numEvents: eventData.numEvents.toDouble(),
        color: eventData.color
      ));
    });
    return result;
  }

  void _paintLines(Canvas canvas, Size size) {
    for (int i = 1; i <= 10; i += 2) {
      double y = map(1 - i * 0.1, 0, 1, 0, size.height);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y), 
        Paint()..color = Colors.black
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintLines(canvas, size);
    List<BarData> series = _series;
    List<double> starts = _starts;
    double maxValue = maxBarData(series);
    double barWidth = _barWidth;
    for (int i = 0; i < series.length; i++) {
      double unitData = map(series[i].numEvents, 0, maxValue, 0, 1);
      double startX = map(starts[i], 0, 1, 0, size.width);
      double startY = map(1, 0, 1, 0, size.height);
      double endX = map(starts[i] + barWidth, 0, 1, 0, size.width);
      double endY = map(1 - unitData, 0, 1, 0, size.height);
      canvas.drawRect(
        Rect.fromPoints(
          Offset(startX, startY), 
          Offset(endX, endY)
        ),
        Paint()..color = HexColor(series[i].color)
      );
    }
  }

  @override
  bool shouldRepaint(BarChartPainter oldPainter) => false;
}

class EmptyBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}