import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'barchart.dart';
import 'eventdata.dart';
import 'barchartcontrols.dart';

class MainPage extends StatelessWidget {
  MainPage({
    this.signOutCallback
  });
  final VoidCallback signOutCallback;

  void _signOut(BuildContext context) {    
    Navigator.of(context).pop();
    AuthProvider.of(context).auth.signOut(signOutCallback);
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
            CircularProgressIndicator(),
            BarChartControls(
              calendarEventsData: List<EventData>()
            )
          ],
        );
      }
      else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            BarChart(
              width: barChartWidth,
              height: barChartHeight,
              data: _extractData(snapshot.data),
              colors: _extractColors(snapshot.data),
            ),
            BarChartControls(
              calendarEventsData: snapshot.data
            )
          ],
        );
      }
    },);

  }

  @override
  Widget build(BuildContext context) {
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