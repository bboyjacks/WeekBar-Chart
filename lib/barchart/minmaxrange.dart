import 'package:flutter/material.dart';

class MinMaxRange {
  double extraXPadding;
  double extraYPadding;
  final double padding;
  final double width;
  final double height;
  final bool xLabelExist;
  final bool yLabelExist;
  MinMaxRange(
    {
    @required this.height,
    this.padding = 10.0, 
    @required this.width,
    this.xLabelExist = true,
    this.yLabelExist = true
    }
  ) {
    this.extraXPadding = (this.yLabelExist) ? 14.0 : 0.0;
    this.extraYPadding = (this.xLabelExist) ? 14.0 : 0.0;
  }

  Map<String, double> get origin {
    return {
      "x": this.padding + this.extraXPadding,
      "y": this.height - this.padding - this.extraYPadding
    };
  }

  Map<String, double> get yMax {
    return {
      "x": this.padding + this.extraXPadding,
      "y": this.padding
    };
  }

  Map<String, double> get xMax {
    return {
      "x": this.width - this.padding,
      "y": this.height - this.padding - this.extraYPadding
    };
  }

}