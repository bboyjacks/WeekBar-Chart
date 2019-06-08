import 'dart:async';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'daterange.dart';
import 'eventdata.dart';

enum BarChartStates {
  noData,
  dataFetching,
  dataAvailable
}

class AppBloc {
  ValueNotifier<BarChartStates> barChartStateNotifier;
  List<EventData> eventDatas = [];
  StreamController<DateRange> calendarEventsStreamController =
      StreamController<DateRange>.broadcast();
  StreamSink<DateRange> get calendarEventsStreamSink =>
      calendarEventsStreamController.sink;

  StreamController<List<EventData>> dataSeriesStreamController =
      StreamController<List<EventData>>.broadcast();
  StreamSink<List<EventData>> get _dataSeriesStreamSink =>
      dataSeriesStreamController.sink;

  AppBloc() {
    barChartStateNotifier = ValueNotifier(BarChartStates.noData);
    calendarEventsStreamController.stream.listen(_mapDateRangeToDataSeriesList);
    dataSeriesStreamController.stream.listen(_mapEventDataToResult);
  }

  void _mapDateRangeToDataSeriesList(DateRange dateRange) {
    GoogleCalendarApi.getEventListByDateRange(dateRange).then((eventsList){
      _dataSeriesStreamSink.add(eventsList);
    });
  }

  void _mapEventDataToResult(List<EventData> result) {
    eventDatas.clear();
    eventDatas = result;
    barChartStateNotifier.value = BarChartStates.dataAvailable;
  }

  void reset() {
    eventDatas.clear();
  }

  void dispose() {
    calendarEventsStreamController.close();
    dataSeriesStreamController.close();
  }
}
