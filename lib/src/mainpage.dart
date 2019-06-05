import 'dart:async';
import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'appbloc.dart';
import 'barchart.dart';
import 'eventdata.dart';
import 'eventslabels.dart';

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

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  StreamSubscription<List<EventData>> stream;
  MainPageStatus status = MainPageStatus.notReady;
  List<EventData> calendarEventsData;
  AnimationController animationController;
  Tween<double> controller;

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
      duration: Duration(
        milliseconds: 800
      ),
      vsync: this
    );
    controller = Tween(begin: 0.0, end: 1.0);
  }

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
    double barChartWidth = AuthProvider.of(context).barChartWidth;
    double barChartHeight = AuthProvider.of(context).barChartHeight;
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
      animationController.forward();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          BarChart(
            width: barChartWidth,
            height: barChartHeight,
            data: _extractData(calendarEventsData),
            colors: _extractColors(calendarEventsData),
            animation: controller.animate(animationController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EventsLabel(
              calendarEventsData: calendarEventsData
            ),
          )
        ],
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
    animationController.dispose();
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