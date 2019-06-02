import 'dart:async';
import 'package:barchart/barchart/dataseries.dart';

import 'auth.dart';
import 'daterange.dart';

class AppBloc {
  List<DataSeries> result = [];
  StreamController<DateRange> calendarEventsStreamController =
      StreamController<DateRange>();

  StreamSink<DateRange> get calendarEventsStreamSink =>
      calendarEventsStreamController.sink;

  StreamController<List<DataSeries>> dataSeriesStreamController =
      StreamController<List<DataSeries>>();
  StreamSink<List<DataSeries>> get _dataSeriesStreamSink =>
      dataSeriesStreamController.sink;
  Stream<List<DataSeries>> get dataSeriesStream =>
      dataSeriesStreamController.stream;

  AppBloc() {
    calendarEventsStreamController.stream.listen(_mapDateRangeToDataSeriesList);
  }

  void _mapDateRangeToDataSeriesList(DateRange dateRange) {
    GoogleCalendarApi.getCalendarListByDateRange(dateRange).then((calendars){
      calendars.items.forEach((calendar){

        GoogleCalendarApi.getCalendarEventsByDateRange(calendar.id, dateRange).then((events){
          // result.add(events);
          // _dataSeriesStreamSink.add(result);
        });
      });
    });
    
  }

  void dispose() {
    calendarEventsStreamController.close();
    dataSeriesStreamController.close();
  }
}
