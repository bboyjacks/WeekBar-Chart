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
        children: [
          BarChart(
            width: 400,
            height: 200
          ),
          MainPageBody()
        ]
      )
    );
  }
}