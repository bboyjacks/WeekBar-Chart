double map(double val, double inStart, double inEnd, double outStart, double outEnd) {
  // (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  return (val - inStart) * (outEnd - outStart) / (inEnd - inStart) + outStart;
}