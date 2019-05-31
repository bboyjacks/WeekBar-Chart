import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'auth.dart';
import 'rootpage.dart';
import 'appbloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      appBloc: AppBloc(),
      child: MaterialApp(
        home: RootPage()
      )
    );
  }
}