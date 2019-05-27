import 'package:flutter/material.dart';
import 'dataserieslist.dart';
import 'multiseriesbarchartcanvas.dart';
import 'debugcontainer.dart';

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
    return Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: MultiSeriesBarChartCanvas(
                width: widget.width,
                height: widget.height,
                animation: animation.animate(animationController),
                dataSeriesList: widget.dataSeriesList.unitize(),
            )
          ),
          BarLabel(left: 38, top: 190, text: "MON",),
          BarLabel(left: 87, top: 190, text: "TUE",),
          BarLabel(left: 135, top: 190, text: "WED",),
          BarLabel(left: 185, top: 190, text: "THU",),
          BarLabel(left: 235, top: 190, text: "FRI",),
          BarLabel(left: 283, top: 190, text: "SAT",),
          BarLabel(left: 333, top: 190, text: "SUN",)
        ],
      );
  }
}

class BarLabel extends StatelessWidget {
  BarLabel({
    this.top,
    this.left,
    this.text
  });
  final double top;
  final double left;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
            top: top,
            left: left,
            child: CenteredText(text: text, width: 40.0, height: 30.0,)
    );
  }
}

class CenteredText extends StatelessWidget {
  CenteredText(
    {
      this.text,
      this.width, 
      this.height
    }
  );
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Text(text)
    );
  }
}