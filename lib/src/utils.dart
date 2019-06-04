import 'dart:ui';

double map(double val, double inStart, double inEnd, double outStart, double outEnd) {
  // (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  return (val - inStart) * (outEnd - outStart) / (inEnd - inStart) + outStart;
}

double max(List<double> data) {
  double max = -double.infinity;
  data.forEach((item) {
    if (max < item) {
      max = item;
    }
  });
  return max;
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class BarData {
  BarData(
    {
      this.numEvents,
      this.color
    }
  );

  final double numEvents;
  final String color;
}