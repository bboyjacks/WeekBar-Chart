import 'dart:async';
import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'appbloc.dart';
import 'barchart.dart';
import 'eventdata.dart';

class MainPage extends StatefulWidget {
  MainPage({
    this.signOutCallback
  });
  final VoidCallback signOutCallback;
  @override
  _MainPageState createState() => _MainPageState();
}

enum MainPageStatus {
  notReady,
  ready
}

class _MainPageState extends State<MainPage> {
  StreamSubscription<List<EventData>> stream;
  MainPageStatus status = MainPageStatus.notReady;
  List<EventData> calendarEventsData;
  final double barChartWidth = 400.0;
  final double barChartHeight = 200.0;

  void _signOut(BuildContext context) {
    AuthProvider.of(context).auth.signOut(widget.signOutCallback);
  }

  void _initializeCalendar(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
      appBloc.reset();
      appBloc.calendarEventsStreamSink.add(DateRange(
        start: DateTime(2018), 
        end: DateTime.now(),
        auth: AuthProvider.of(context).auth
      )
    );
  }

  void _initializeDataListener(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
    if (stream == null) {
      stream = appBloc.dataSeriesStream.listen(_dataChanged);
    }
  }

  void _dataChanged(List<EventData> data) {
    calendarEventsData = data;
    setState((){
      status = MainPageStatus.ready;
    });
  }

  List<double> _extractData(List<EventData> data) {
    List<double> result = [];
    data.forEach((item){
      result.add(item.numEvents.toDouble());
    });
    return result;
  }

  List<String> _extractColors(List<EventData> data) {
    List<String> result = [];
    data.forEach((item){
      result.add(item.color);
    });
    return result;
  }

  Widget _body(BuildContext context) {
    if (status == MainPageStatus.notReady) {
      return Column(
        children: <Widget>[
          SizedBox(height: 20,),
          EmptyBarChart(
            width: barChartWidth,
            height: barChartHeight
          ),
        ],
      );
    }
    else {
      return Column(
        children: <Widget>[
          SizedBox(height: 20,),
          BarChart(
            width: barChartWidth,
            height: barChartHeight,
            data: _extractData(calendarEventsData),
            colors: _extractColors(calendarEventsData)
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _initializeCalendar(context);
    _initializeDataListener(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Visual G Calendar"),
      ),
      drawer: Drawer(
          child: FlatButton(
        child: Text("Sign out"),
        onPressed: () {
          _signOut(context);
        },
      )),
      body: _body(context)
    );
  }
}



