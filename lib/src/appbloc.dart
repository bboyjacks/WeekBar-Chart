import 'dart:async';

import 'auth.dart';
import 'daterange.dart';
import 'eventdata.dart';

class AppBloc {
  List<EventData> result = [];
  StreamController<DateRange> calendarEventsStreamController =
      StreamController<DateRange>();

  StreamSink<DateRange> get calendarEventsStreamSink =>
      calendarEventsStreamController.sink;

  StreamController<List<EventData>> dataSeriesStreamController =
      StreamController<List<EventData>>();
  StreamSink<List<EventData>> get _dataSeriesStreamSink =>
      dataSeriesStreamController.sink;
  Stream<List<EventData>> get dataSeriesStream =>
      dataSeriesStreamController.stream;

  AppBloc() {
    calendarEventsStreamController.stream.listen(_mapDateRangeToDataSeriesList);
  }

  void _mapDateRangeToDataSeriesList(DateRange dateRange) {
    GoogleCalendarApi.getCalendarListByDateRange(dateRange).then((calendars){
      calendars.items.forEach((calendar){

        GoogleCalendarApi.getCalendarEventsByDateRange(calendar.id, dateRange).then((events){
          result.add(events);
          _dataSeriesStreamSink.add(result);
        });
      });
    });
    
  }

  void dispose() {
    calendarEventsStreamController.close();
    dataSeriesStreamController.close();
  }
}
