import 'package:flutter/material.dart';
import 'authprovider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({this.signInCallback});
  final VoidCallback signInCallback;

  void _login(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signIn();
    print("login in");
    if (auth.currentUser() != null) {
      print("Logged in");
      signInCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text("Log in"),
          onPressed: (){
            _login(context);
          },
        )
      )
    );
  }
  
}