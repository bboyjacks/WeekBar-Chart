import 'package:flutter/material.dart';

class EventDataValueNotifier extends ValueNotifier<List<double>> {
  EventDataValueNotifier(List<double> value) : super(value);

  void update(List<double> data) {
    value = data;    
  }
}