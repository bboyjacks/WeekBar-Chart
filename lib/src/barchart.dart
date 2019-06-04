import 'package:flutter/material.dart';

import 'appbloc.dart';
import 'authprovider.dart';
import 'eventdatavaluenotifier.dart';
import 'eventdata.dart';
import 'dart:async';
import 'barchartcanvas.dart';




class BarChart extends StatefulWidget {
  BarChart({
    this.width,
    this.height
  });
  final double width;
  final double height;

  @override
  _BarChartState createState() => _BarChartState();
}

enum BarChartDataStatus {
  empty,
  notEmpty
}

class _BarChartState extends State<BarChart> {

  EventDataValueNotifier listOfEventDatas;
  BarChartDataStatus status = BarChartDataStatus.empty;
  StreamSubscription<List<EventData>> stream;

  @override
  void initState() {
    super.initState();
    listOfEventDatas = EventDataValueNotifier([]);    
  }

  void _dataChanged(List<EventData> data) {
    listOfEventDatas.update(data);
    setState(() {
      status = BarChartDataStatus.notEmpty;
    });
  }

  @override
    void dispose() {
      super.dispose();
      stream.cancel();
    }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AuthProvider.of(context).appBloc;
    if (stream == null) {
      stream = appBloc.dataSeriesStream.listen(_dataChanged);
    }

    if (status == BarChartDataStatus.empty) {
      return EmptyBarChartCanvas(
        width: widget.width,
        height: widget.height
      );
    }
    else {
      return Column(
        children: <Widget>[
          BarChartCanvas(
            width: widget.width,
            height: widget.height,
            listOfEventDatas: listOfEventDatas,
          ),
        ],
      );
    }
  }
}
