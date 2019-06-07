import 'package:flutter/material.dart';
import 'barchartpainter.dart';
import 'utils.dart';

class BarChart extends StatefulWidget {
  BarChart(
    {
      this.width,
      this.height,
      this.data,
      this.colors,
    }
  );
  final double width;
  final double height;
  final List<double> data;
  final List<String> colors;

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

  BoxDecoration _boxShadow() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.grey
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 10,
          color: Colors.grey
        ),
        BoxShadow(
          color: Colors.white
        )
      ]
    );
  }

  Widget barChartPainter() {
    animationController.reset();
    animationController.forward();
    return FittedBox(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          painter: BarChartPainter(
            max: max(widget.data),
            data: widget.data,
            colors: widget.colors,
            animation: animation.animate(animationController)
          ),
          size: Size(widget.width, widget.height),
        )
      )
    ,);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: _boxShadow(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: barChartPainter(),
          ),
        ),
    );
  }
}