import 'dart:core';
import 'auth.dart';

class DateRange {
  DateRange({
    this.start,
    this.end,
    this.auth
  });
  final DateTime start;
  final DateTime end;
  final BaseAuth auth;
}