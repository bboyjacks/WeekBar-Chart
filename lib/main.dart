import 'package:flutter/material.dart';
import 'multiseriesbarchart.dart';
import 'dataseries.dart';
import 'debugcontainer.dart';
import 'dataserieslist.dart';

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

  final DataSeries dataSeries3 = DataSeries(
    m: 30,
    t: 30,
    w: 45,
    th: 49,
    f: 80,
    s: 95,
    sd: 76 
  );

  final DataSeries dataSeries4 = DataSeries(
    m: 30,
    t: 30,
    w: 12,
    th: 49,
    f: 80,
    s: 45,
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
            child: Row(
              children: [
                Flexible(
                  child: DebugContainer(
                    child: MultiSeriesBarChart(
                      dataSeriesList: DataSeriesList(
                        dataSeriesList: [
                          dataSeries1,
                          dataSeries2,
                          dataSeries3,
                          dataSeries4
                        ]
                      ),
                    )
                  )
                ),
              ]
            )
          )
        ),
      ),
    );
  }
}