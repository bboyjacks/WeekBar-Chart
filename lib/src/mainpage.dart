import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'eventdata.dart';
import 'appbloc.dart';

class MainPage extends StatefulWidget {
  MainPage({this.signOutCallback});
  final VoidCallback signOutCallback;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  void _signOut(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signOut(() {
      Navigator.pop(context);
      widget.signOutCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      drawer: Drawer(
          child: FlatButton(
        child: Text("Sign out"),
        onPressed: () {
          _signOut(context);
        },
      )),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          appBloc.calendarEventsStreamSink.add(DateRange(
            start: DateTime(2018), 
            end: DateTime.now(),
            auth: AuthProvider.of(context).auth
          )
        );
      }),
    );
  }
}

class BarChart extends StatelessWidget {
  BarChart(
    {
      this.width,
      this.height,
      this.data
    }
  );
  final double width;
  final double height;
  final List<EventData> data;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red
        )
      ),
      child: FittedBox(
        child: SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: BarChartPainter(
              data: data
            ),
            size: Size(width, height)
          )
        )
      ),
    );
  }
}

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

class BarChartPainter extends CustomPainter {
  BarChartPainter(
    {
      this.data
    } 
  );
  final _barGap = 0.01;
  List<EventData> data;

  double get _barWidth {
    final n = this.data.length;
    return (1 - _barGap * (n + 1))/ n;
  }

  List<double> _calcStarts() {
    List<double> result = [];
    if (this.data.length > 0) {
      double currentStart = _barGap;
      while (currentStart + _barWidth < 1) {
        // get next start
        result.add(currentStart);
        currentStart += (_barWidth + _barGap);
      }
    }
    return result;
  }

  void _paintBar(Canvas canvas, Size size, double start, double numEvents) {
    List<double> eventDataNumEvents = this.data.map((val) => val.numEvents.toDouble()).toList();
    double maximumVal = max(eventDataNumEvents);
    double height = map(numEvents, 0, maximumVal, 0, 1);
    double xStart = map(start, 0, 1, 0, size.width);
    double yStart = map(1, 0, 1, 0, size.height);
    double xEnd = map(start + _barWidth, 0, 1, 0, size.width);
    double yEnd = map(1 - height, 0, 1, 0, size.height);
    canvas.drawRect(
      Rect.fromPoints(
        Offset(xStart, yStart), 
        Offset(xEnd, yEnd)
      ),
      Paint()..color = Colors.red
    );  
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("repainting");
    List<double> starts = _calcStarts();
    for (int i = 0; i < this.data.length; i++) {
      double numEvents = this.data[i].numEvents.toDouble();
      double barStart = starts[i];
      _paintBar(canvas, size,  barStart, numEvents);
    }
  }

  @override
  bool shouldRepaint(BarChartPainter oldPainter) => oldPainter.data.length != data.length;
}