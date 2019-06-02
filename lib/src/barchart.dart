import 'package:flutter/material.dart';

import 'appbloc.dart';
import 'authprovider.dart';
import 'eventdatavaluenotifier.dart';
import 'eventdata.dart';


double map(double val, double inStart, double inEnd, double outStart, double outEnd) {
  // (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  return (val - inStart) * (outEnd - outStart) / (inEnd - inStart) + outStart;
}

double max(List<double> data) {
  double max = -double.infinity;
  data.forEach((item) {
    if (max < item) {
      max = item;
    }
  });
  return max;
}

class BarChart extends StatefulWidget {
  BarChart({
    this.width,
    this.height
  });
  final double width;
  final double height;

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {

  EventDataValueNotifier listOfEventDatas;

  @override
  void initState() {
    super.initState();
    listOfEventDatas = EventDataValueNotifier([]);    
  }

  void _dataChanged(List<EventData> data) {
    List<double> newValues = [];
    data.forEach((item){
      newValues.add(item.numEvents.toDouble());
    });
    listOfEventDatas.update(newValues);
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
    appBloc.dataSeriesStream.listen(_dataChanged);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red
          )
        ),
        child: FittedBox(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: CustomPaint(
              painter: BarChartPainter(
                data: listOfEventDatas
              ),
              size: Size(widget.width, widget.height),
            )
          )
        ,),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  BarChartPainter(
    {
      this.data
    }
  ) : super(repaint: data);
  final EventDataValueNotifier data;
  final double _barGap = 0.01;

  double get _barWidth {
    int n = data.value.length;
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

  @override
  void paint(Canvas canvas, Size size) { 
    List<double> starts = _starts;
    double maxValue = max(data.value);
    double barWidth = _barWidth;
    for (int i = 0; i < data.value.length; i++) {
      double unitData = map(data.value[i], 0, maxValue, 0, 1);
      double startX = map(starts[i], 0, 1, 0, size.width);
      double startY = map(1, 0, 1, 0, size.height);
      double endX = map(starts[i] + barWidth, 0, 1, 0, size.width);
      double endY = map(1 - unitData, 0, 1, 0, size.height);
      canvas.drawRect(
        Rect.fromPoints(
          Offset(startX, startY), 
          Offset(endX, endY)
        ),
        Paint()..color = Colors.red
      );
    }
  }

  @override
  bool shouldRepaint(BarChartPainter oldPainter) => false;
}