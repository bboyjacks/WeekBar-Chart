import 'dart:async';
import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'appbloc.dart';
import 'barchart.dart';
import 'eventdata.dart';
import 'barchartcontrols.dart';

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
  MainPageStatus status = MainPageStatus.notReady;
  AnimationController animationController;
  Tween<double> controller;
  DateTime startTime;
  DateTime endTime;

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
    startTime = DateTime(2018);
    endTime = DateTime.now();
  }

  void _signOut(BuildContext context) {    
    Navigator.of(context).pop();
    AuthProvider.of(context).auth.signOut(widget.signOutCallback);
  }

  void _initializeCalendar(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
    appBloc.reset();
    appBloc.calendarEventsStreamSink.add(DateRange(
        start: startTime, 
        end: endTime,
        auth: AuthProvider.of(context).auth
      )
    );
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
    return StreamBuilder(
      stream: AuthProvider.of(context).appBloc.dataSeriesStream,
      builder: (BuildContext context, AsyncSnapshot<List<EventData>> snapshot) {
      if (!snapshot.hasData) {
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
              data: _extractData(snapshot.data),
              colors: _extractColors(snapshot.data),
              animation: controller.animate(animationController),
            ),
            BarChartControls(
              calendarEventsData: snapshot.data,
              dateAction: (start, end) {
                setState(() {
                  startTime = start;
                  endTime = end;                
                });
              },
            )
          ],
        );
      }
    },);

  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initializeCalendar(context);
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