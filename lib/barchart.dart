import 'package:flutter/material.dart';
import 'barchartcanvas.dart';

class BarChart extends StatefulWidget {
  BarChart({this.data});
  final List<double> data;
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> with SingleTickerProviderStateMixin {
  static const canvasWidth = 400.0;
  static const canvasHeight = 200.0;
  AnimationController animationController;
  Tween<double> animation;
  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 500), vsync:  this);
    animation = Tween(begin: 0, end: 1);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: canvasWidth,
        height: canvasHeight,
        child: BarChartCanvas(
          width: canvasWidth,
          height: canvasHeight,
          data: widget.data,
          tween: animation.animate(animationController)
        ),
      )
    );
  }
}