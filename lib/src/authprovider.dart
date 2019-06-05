import 'package:flutter/material.dart';
import 'auth.dart';
import 'appbloc.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({Key key, Widget child, this.auth, this.appBloc}) : super(key: key, child: child);
  final BaseAuth auth;
  final AppBloc appBloc;
  final double barChartWidth = 400.0;
  final double barChartHeight = 200.0;
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static AuthProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AuthProvider);
  }
}