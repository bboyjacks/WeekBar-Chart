
class Utils {
  static double map(val, originalMin, originalMax, newMin, newMax) {
    return (val - originalMin) * (newMax - newMin) / (originalMax - originalMin) + newMin;
  }

  static double max(List<double> data) {
    double max = double.negativeInfinity;
    data.forEach((x) {
      if (x > max) {
        max = x;
      }
    });
    return max;
  }
}