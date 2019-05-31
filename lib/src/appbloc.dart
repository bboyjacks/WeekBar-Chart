import 'dart:async';

import 'auth.dart';
import 'daterange.dart';
import '../barchart/dataserieslist.dart';

class AppBloc {
  StreamController<DateRange> calendarEventsStreamController =
      StreamController<DateRange>();

  StreamSink<DateRange> get calendarEventsStreamSink =>
      calendarEventsStreamController.sink;

  StreamController<DataSeriesList> dataSeriesStreamController =
      StreamController<DataSeriesList>();
  StreamSink<DataSeriesList> get _dataSeriesStreamSink =>
      dataSeriesStreamController.sink;
  Stream<DataSeriesList> get dataSeriesStream =>
      dataSeriesStreamController.stream;

  AppBloc() {
    calendarEventsStreamController.stream.listen(_mapDateRangeToDataSeriesList);
  }

  void _mapDateRangeToDataSeriesList(DateRange dateRange) {
    final dataSeriesList = GoogleCalendarApi.getEventsByDateRange(dateRange);
    _dataSeriesStreamSink.add(dataSeriesList);
  }

  void dispose() {
    calendarEventsStreamController.close();
    dataSeriesStreamController.close();
  }
}
