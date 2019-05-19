
class Utils {
  static double map(val, originalMin, originalMax, newMin, newMax) {
    return (val - originalMin) * (newMax - newMin) / (originalMax - originalMin) + newMin;
  }
}