import 'package:flutter/material.dart';
import 'barchart/barchart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    List<double> data = [];
    List<String> labels = [];
    var labelsList = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'x',
      'y',
      'z',
      'aa',
      'ab',
      'ac',
      'ad',
      'ae',
      'af',
      'ag',
      'ah',
      'ai',
      'aj',
      'ak',
      'al',
      'am',
      'an',
      'ao',
      'ap',
      'aq',
      'ar',
      'as',
      'at',
      'au',
      'av',
      'ax',
      'ay',
      'az',
      'aaa',
      'aab',
      'aac',
      'aad',
      'aae',
      'aaf',
      'aag',
      'aah',
      'aai',
      'aaj',
      'aak',
      'aal',
      'aam',
      'aan',
      'aao',
      'aap',
      'aaq',
      'aar',
      'aas',
      'aat',
      'aau',
      'aav',
      'aax',
      'aay',
      'aaz',
      'aaaa',
      'aaab',
      'aaac',
      'aaad',
      'aaae',
      'aaaf',
      'aaag',
      'aaah',
      'aaai',
      'aaaj',
      'aaak',
      'aaal',
      'aaam',
      'aaan',
      'aaao',
      'aaap',
      'aaaq',
      'aaar',
      'aaas',
      'aaat',
      'aaau',
      'aaaar',
      'aaaas',
      'aaaat',
      'aaaau'
    ];
    for (int i = 0; i < 10; i++) {
      data.add(20.0 * (i + 1));
      labels.add(labelsList[i]);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bar Chart"),
        ),
        body: BarChart(
          data: data,
          xLabels: labels,
        ),
      ),
    );
  }
}
