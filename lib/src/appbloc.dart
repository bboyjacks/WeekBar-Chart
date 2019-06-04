import 'dart:async';

import 'auth.dart';
import 'daterange.dart';
import 'eventdata.dart';

class AppBloc {
  List<EventData> result = [];
  Map<String, String> colors = {};
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
        colors[calendar.summary] = calendar.backgroundColor;
        GoogleCalendarApi.getCalendarEventsByDateRange(calendar.id, dateRange).then((events){
          if (!(events is EmptyEventData)) {

            events.color = colors[events.summary];
            result.add(events);
            _dataSeriesStreamSink.add(result);
          }
        });
      });
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
