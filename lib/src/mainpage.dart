import 'package:flutter/material.dart';
import 'authprovider.dart';


class MainPage extends StatelessWidget {
  MainPage({this.signOutCallback});
  final VoidCallback signOutCallback;

  void _signOut(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signOut((){ 
      Navigator.pop(context);
      signOutCallback(); 
    });
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
          onPressed: (){_signOut(context);},
        )
      ),
      body: Container()
    );
  }

}