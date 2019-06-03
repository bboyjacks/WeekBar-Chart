import 'package:flutter/material.dart';

import 'eventdata.dart';

class EventDataValueNotifier extends ValueNotifier<List<EventData>> {
  EventDataValueNotifier(List<EventData> value) : super(value);

  void update(List<EventData> data) {
    value = data;
    notifyListeners();
  }
}