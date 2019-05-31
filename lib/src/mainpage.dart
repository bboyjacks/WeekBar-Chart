import 'package:flutter/material.dart';
import 'authprovider.dart';


class MainPage extends StatelessWidget {
  MainPage({this.signOutCallback});
  final VoidCallback signOutCallback;

  void _signOut(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signOut((){ signOutCallback(); });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text("Sign out"),
          onPressed: (){_signOut(context);},
        )
      )
    );
  }

}