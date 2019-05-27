import 'package:flutter/material.dart';
import 'dataserieslist.dart';
import 'multiseriesbarchartpainter.dart';

class MultiSeriesBarChart extends StatefulWidget {
  MultiSeriesBarChart({this.dataSeriesList});
  final DataSeriesList dataSeriesList;
  final double width = 430.0;
  final double height = 200.0;

  @override
  _MultiSeriesBarChartState createState() => _MultiSeriesBarChartState();
}

class _MultiSeriesBarChartState extends State<MultiSeriesBarChart> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Tween<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 10000),
      vsync: this
    );

    animation = Tween(begin: 0, end: 1);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: widget.width,
        child: CustomPaint(
          painter: MultiSeriesBarChartPainter(
            animation.animate(animationController),
            unitDataSeries: widget.dataSeriesList.unitize()
          ),
          size: Size(widget.width, widget.height),
        )
      )
    );
  }
}