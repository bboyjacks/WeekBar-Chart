import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'mainpage.dart';

enum AuthState {
  notDetermined,
  notSignedIn,
  signedIn
}

class RootPage extends StatefulWidget{
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthState authState = AuthState.notDetermined;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void signIn() {
    setState((){
      authState = AuthState.signedIn;
    });
  }

  void signOut() {
    setState(() {
      authState = AuthState.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authState == AuthState.notSignedIn)
      return LoginPage(
        signInCallback: signIn
      );
    else if (authState == AuthState.signedIn)
      return MainPage(
        signOutCallback: signOut
      );
    return Center(
      child: CircularProgressIndicator()
    );
  }
}