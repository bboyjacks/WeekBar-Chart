import 'package:flutter/material.dart';

import 'appbloc.dart';
import 'authprovider.dart';
import 'eventdatavaluenotifier.dart';
import 'eventdata.dart';
import 'dart:async';


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

double maxBarData(List<BarData> data) {
  double max = -double.infinity;
  data.forEach((item) {
    if (max < item.numEvents) {
      max = item.numEvents;
    }
  });
  return max;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
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

enum BarChartDataStatus {
  empty,
  notEmpty
}

class _BarChartState extends State<BarChart> {

  EventDataValueNotifier listOfEventDatas;
  BarChartDataStatus status = BarChartDataStatus.empty;
  StreamSubscription<List<EventData>> stream;

  @override
  void initState() {
    super.initState();
    listOfEventDatas = EventDataValueNotifier([]);    
  }

  void _dataChanged(List<EventData> data) {
    listOfEventDatas.update(data);
    setState(() {
      status = BarChartDataStatus.notEmpty;
    });
  }

  @override
    void dispose() {
      super.dispose();
      stream.cancel();
    }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
    if (stream == null) {
      stream = appBloc.dataSeriesStream.listen(_dataChanged);
    }

    if (status == BarChartDataStatus.empty) {
      return Center(child: CircularProgressIndicator());
    }
    else {
      return Column(
        children: <Widget>[
          BarChartCanvas(
            width: widget.width,
            height: widget.height,
            listOfEventDatas: listOfEventDatas,
          ),
        ],
      );
    }
  }
}

class BarChartCanvas extends StatelessWidget {
  BarChartCanvas(
    {
      this.width,
      this.height,
      this.listOfEventDatas
    }
  );

  final double width;
  final double height;
  final EventDataValueNotifier listOfEventDatas;

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      color: Colors.grey
                    ),
                    BoxShadow(
                      color: Colors.white
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: CustomPaint(
                        painter: BarChartPainter(
                          data: listOfEventDatas
                        ),
                        size: Size(width, height),
                      )
                    )
                  ,),
                ),
              ),
            ),
          );
  }

}

class BarData {
  BarData(
    {
      this.numEvents,
      this.color
    }
  );

  final double numEvents;
  final String color;
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

  List<BarData> get _series {
    List<BarData> result = [];
    data.value.forEach((eventData) {
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