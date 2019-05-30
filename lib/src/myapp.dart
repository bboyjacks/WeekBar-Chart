import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'auth.dart';
import 'rootpage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        home: Container(
          color: Colors.blue[400],
          child: RootPage()
        )
      )
    );
  }
}