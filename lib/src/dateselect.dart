import 'package:flutter/material.dart';

class DateSelect extends StatefulWidget {
  DateSelect(
    {
      this.valueNotifier,
      this.name
    }
  );
  final ValueNotifier valueNotifier;
  final String name;
  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {

  Widget _date(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.valueNotifier,
      builder: (context, value, _) {
        if (value == null) {
          return Text(widget.name);
        }
        else {
          return Text("${value.month.toString()}/${value.day.toString()}/${value.year.toString()}");
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: _date(context),
    );
  }

}