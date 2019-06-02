import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'eventdata.dart';
import 'appbloc.dart';
import 'barchartpainter.dart';
import 'eventdatavaluenotifier.dart';

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


class MainPage extends StatefulWidget {
  MainPage({
    this.signOutCallback
  });
  final VoidCallback signOutCallback;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BarChartPainter barChartPainter;
  EventDataValueNotifier values;

  @override
  void initState() {
    super.initState();
    values = EventDataValueNotifier([]);
    barChartPainter = BarChartPainter(
      data: values
    );
  } 

  void _changeHappened(List<EventData> newData) {
    List<double> newValues = [];
    newData.forEach((data) {
      newValues.add(data.numEvents.toDouble());
    });
    values.update(newValues);
  }

  void _signOut(BuildContext context) {
    AuthProvider.of(context).auth.signOut(widget.signOutCallback);
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
    appBloc.dataSeriesStream.listen(_changeHappened);
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
      body: CustomPaint(
        painter: barChartPainter,
        size: Size(400, 200)
        ,),
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



