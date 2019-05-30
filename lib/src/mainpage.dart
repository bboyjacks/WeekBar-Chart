import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  MainPage({this.signOutCallback});
  final VoidCallback signOutCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text("Sign out"),
          onPressed: signOutCallback,
        )
      )
    );
  }

}