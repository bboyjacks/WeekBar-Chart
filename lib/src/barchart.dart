import 'package:flutter/material.dart';

import 'appbloc.dart';
import 'authprovider.dart';
import 'barchartpainter.dart';
import 'eventdata.dart';
import 'utils.dart';

class BarChart extends StatefulWidget {
  BarChart(
    {
      this.width,
      this.height,
    }
  );
  final double width;
  final double height;
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Tween<double> animation;
  
  
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    animation = Tween(begin: 0, end: 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<double> _extractValues(List<EventData> data) {
    List<double> result = [];
    data.forEach((item) {
      result.add(item.numEvents.toDouble());
    });
    return result;
  }

  List<String> _extractColors(List<EventData> data) {
    List<String> result = [];
    data.forEach((item){
      result.add(item.color);
    });
    return result;
  }

  Widget _barChart(BuildContext context) {
    return ValueListenableBuilder<BarChartStates>(
      valueListenable: AuthProvider.of(context).appBloc.barChartStateNotifier,
      builder: (context, value, _) {
        if (value == BarChartStates.noData) {
          return Text("No date selected. Please select dates."); // select date message
        } else if(value == BarChartStates.dataFetching) {
          return CircularProgressIndicator(); // circular progress indicator
        } else {
          animationController.reset();
          animationController.forward();
          List<EventData> data = AuthProvider.of(context).appBloc.eventDatas;
          List<double> values = _extractValues(data);
          return CustomPaint(
            painter: BarChartPainter(
              max: max(values),
              colors: _extractColors(data),
              data: values,
              animation: animation.animate(animationController)
            ),
            size: Size(widget.width, widget.height),
          );
        }
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[400]
        ),
        boxShadow: [
          BoxShadow(offset: Offset(0, 5), blurRadius: 10.0, color: Colors.grey[200])
        ]
      ),
      child: FittedBox(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Center(child: _barChart(context))
        )
      )
    );
  }
}