import 'package:flutter/material.dart';
import 'authprovider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({this.signInCallback});
  final VoidCallback signInCallback;

  void _login(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signIn((currentUser){
      signInCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Log in"),
            onPressed: (){
              _login(context);
            },
          )
        )
      )
    );
  }
  
}