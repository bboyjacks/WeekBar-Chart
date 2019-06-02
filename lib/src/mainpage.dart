import 'package:barchart/barchart/dataseries.dart';
import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';

class MainPage extends StatelessWidget {
  MainPage({this.signOutCallback});
  final VoidCallback signOutCallback;

  void _signOut(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signOut(() {
      Navigator.pop(context);
      signOutCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = AuthProvider.of(context).appBloc;

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
      body: StreamBuilder(
        stream: appBloc.dataSeriesStream,
        builder: (BuildContext context, AsyncSnapshot<List<DataSeries>> snapshot) {
          if (snapshot.hasData) {
            print("Received something: ${snapshot.data}");
          }
          else {
            print("Responded but no data");
          }
          return Container();
        }
      ),
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
