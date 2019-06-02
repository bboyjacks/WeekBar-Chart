import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'appbloc.dart';
import 'barchart.dart';


class MainPage extends StatelessWidget {
  MainPage({
    this.signOutCallback
  });
  final VoidCallback signOutCallback;

  void _signOut(BuildContext context) {
    AuthProvider.of(context).auth.signOut(signOutCallback);
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
      body: BarChart(
        width: 400.0,
        height: 200.0
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          AppBloc appBloc = AuthProvider.of(context).appBloc;
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



