import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'barchart.dart';
import 'mainpagebody.dart';

class MainPage extends StatelessWidget {
  MainPage({
    this.signOutCallback
  });
  final VoidCallback signOutCallback;

  void _signOut(BuildContext context) {    
    Navigator.of(context).pop();
    AuthProvider.of(context).auth.signOut(signOutCallback);
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              child: BarChart(
                width: 400,
                height: 200
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(8),
              child: MainPageBody()
            )
          )
        ]
      )
    );
  }
}