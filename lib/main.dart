import 'package:flutter/material.dart';
import 'barchart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bar Chart"),
        ),
        body: SafeArea(
          child: Center(
            child: DebugContainer(
              child: BarChart(
                data: [50, 40, 70, 60, 60, 45]
              )
            )
          )
        ),
      ),
    );
  }
}

class DebugContainer extends StatelessWidget {
  DebugContainer({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1.0
        )
      ),
      child: child
    );
  }
}