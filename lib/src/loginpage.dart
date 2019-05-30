import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({this.signInCallback});
  final VoidCallback signInCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("Login Paige")
      )
    );
  }
  
}