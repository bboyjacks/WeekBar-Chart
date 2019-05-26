import 'package:flutter/material.dart';
import 'multiseriesbarchart.dart';
import 'dataseries.dart';
import 'debugcontainer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  final DataSeries dataSeries1 = DataSeries(
    m: 30,
    t: 40,
    w: 50,
    th: 43,
    f: 89,
    s: 90,
    sd: 74
  );

  final DataSeries dataSeries2 = DataSeries(
    m: 30,
    t: 30,
    w: 45,
    th: 49,
    f: 80,
    s: 95,
    sd: 76 
  );
  
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
              child: MultiSeriesBarChart(
                dataSeries: [
                  dataSeries1,
                  dataSeries2
                ]
              )
            )
          )
        ),
      ),
    );
  }
}