import 'package:flutter/material.dart';
import 'barchartcontrols.dart';
import 'eventsinfo.dart';

class MainPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: EventsInfo()),
        SizedBox(width: 8),
        Expanded(child: BarChartControls())
      ]
    );
  }
}