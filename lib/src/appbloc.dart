import 'dart:async';

import 'auth.dart';
import 'daterange.dart';
import 'eventdata.dart';

class AppBloc {
  List<EventData> result = [];
  Map<String, String> colors = {};
  StreamController<DateRange> calendarEventsStreamController =
      StreamController<DateRange>.broadcast();

  StreamSink<DateRange> get calendarEventsStreamSink =>
      calendarEventsStreamController.sink;

  StreamController<List<EventData>> dataSeriesStreamController =
      StreamController<List<EventData>>.broadcast();
  StreamSink<List<EventData>> get _dataSeriesStreamSink =>
      dataSeriesStreamController.sink;
  Stream<List<EventData>> get dataSeriesStream =>
      dataSeriesStreamController.stream;

  AppBloc() {
    calendarEventsStreamController.stream.listen(_mapDateRangeToDataSeriesList);
  }

  void _mapDateRangeToDataSeriesList(DateRange dateRange) {
    GoogleCalendarApi.getEventListByDateRange(dateRange).then((eventsList){
      _dataSeriesStreamSink.add(eventsList);
    });
  }

  void reset() {
    result.clear();
    colors.clear();
  }

  void dispose() {
    calendarEventsStreamController.close();
    dataSeriesStreamController.close();
  }
}
