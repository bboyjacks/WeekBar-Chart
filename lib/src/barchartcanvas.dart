import 'package:flutter/material.dart';
import 'eventdatavaluenotifier.dart';
import 'barchartpainter.dart';

class BarChartCanvas extends StatelessWidget {
  BarChartCanvas(
    {
      this.width,
      this.height,
      this.listOfEventDatas
    }
  );

  final double width;
  final double height;
  final EventDataValueNotifier listOfEventDatas;
  
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
            data: listOfEventDatas
          ),
          size: Size(width, height),
        )
      )
    ,);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: _boxShadow(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: barChartPainter(),
          ),
        ),
      ),
    );
  }
}

class EmptyBarChartCanvas extends BarChartCanvas {
  EmptyBarChartCanvas(
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