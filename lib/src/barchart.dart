import 'package:flutter/material.dart';
import 'barchartpainter.dart';
import 'utils.dart';

class BarChart extends StatelessWidget {
  BarChart(
    {
      this.width,
      this.height,
      this.data,
      this.colors
    }
  );

  final double width;
  final double height;
  final List<double> data;
  final List<String> colors;
  
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

    return FittedBox(
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: BarChartPainter(
            max: max(data),
            data: data,
            colors: colors
          ),
          size: Size(width, height),
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

class EmptyBarChart extends BarChart {
  EmptyBarChart(
    {
      double width,
      double height
    }
  ) : super(width: width, height: height);

  @override
  Widget barChartPainter() {
    return FittedBox(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: EmptyBarChartPainter(),
              size: Size(width, height),
            ),
            Center(
              child: CircularProgressIndicator()
            )
          ],
        )
      )
    ,);
  }
}