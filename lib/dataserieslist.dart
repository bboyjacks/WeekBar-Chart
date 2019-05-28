import 'dart:collection';
import 'dataseries.dart';
import 'utils.dart';

class DataSeriesList extends ListBase<DataSeries> {
  final List<DataSeries> dataSeriesList;
  DataSeriesList(
    {
      this.dataSeriesList
    }
  );

  @override
  int length;

  @override
  DataSeries operator [](int index) {
    return dataSeriesList[index];
  }

  @override
  void operator []=(int index, DataSeries value) {
    dataSeriesList[index] = value;
  }

  double _getMax() {
    double maxVal = -double.infinity;
    dataSeriesList.forEach((ds){
      List<double> dataPoints = [ds.m, ds.t, ds.w, ds.th, ds.f, ds.s, ds.sd];
      dataPoints.forEach((item){
        if (maxVal < item) {
          maxVal = item;
        }
      });
    });
    return maxVal;
  }

  List<DataSeries> unitize() {
    double maxVal = _getMax();
    List<DataSeries> result = [];
    dataSeriesList.forEach((ds){
      List<double> unitDataPoints = [];
      List<double> dataPoints = [ds.m, ds.t, ds.w, ds.th, ds.f, ds.s, ds.sd];
      dataPoints.forEach((item){
        double unitVal = map(item, 0, maxVal, 0, 1);
        unitDataPoints.add(unitVal);
      });
      DataSeries unitizedDataSeries = DataSeries(
          m: unitDataPoints[0],
          t: unitDataPoints[1],
          w: unitDataPoints[2],
          th: unitDataPoints[3],
          f: unitDataPoints[4],
          s: unitDataPoints[5],
          sd: unitDataPoints[6]
      );
      result.add(unitizedDataSeries);
    });
    return result;
  }

}