
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'appbloc.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'dateselect.dart';


class BarChartControls extends StatefulWidget {
  @override
  _BarChartControlsState createState() => _BarChartControlsState();
}

class _BarChartControlsState extends State<BarChartControls> {
  ValueNotifier startValueNotifier;
  ValueNotifier endValueNotifier;

  @override
  void initState() {
    super.initState();
    DateTime start;
    DateTime end;
    startValueNotifier = ValueNotifier(start);
    endValueNotifier = ValueNotifier(end);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _calendarSelect(context,
          valueNotifier: startValueNotifier,
          buttonSubtext: "start",
          label: "Start Date"
        ),
        SizedBox(height: 20,),
        _calendarSelect(context,
          valueNotifier: endValueNotifier,
          buttonSubtext: "end",
          label: "End Date"
        )
      ]
    );
  }

  Widget _calendarSelect(BuildContext context, {
    ValueNotifier valueNotifier,
    String buttonSubtext,
    String label
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue)
      ),
      width: width * 0.50,
      height: height * 0.045,
      child: Row(
        children: <Widget>[
          Expanded(child: DateSelect(valueNotifier: valueNotifier, name: label)),
          Expanded(
            child: RaisedButton(
              padding: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(FontAwesomeIcons.calendar),
                  SizedBox(width: 4),
                  Text(buttonSubtext)
                ],
              ),
              onPressed: (){
                _selectDate(context).then((endTime) {
                  valueNotifier.value = endTime;
                  _updateState(context);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
    
  void _updateState(BuildContext context) {
    if (startValueNotifier.value != null && endValueNotifier.value != null) {
      if (startValueNotifier.value.isAfter(endValueNotifier.value)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Error"),
              content: new Text("The start date is after the end date."),
            );
          },
        );
      }
      else {
        ValueNotifier barChartStateNotifier = 
          AuthProvider.of(context).appBloc.barChartStateNotifier;
        barChartStateNotifier.value = BarChartStates.dataFetching;

        AppBloc appBloc = AuthProvider.of(context).appBloc;
          appBloc.calendarEventsStreamSink.add(DateRange(
            start: startValueNotifier.value,
            end: endValueNotifier.value,
            auth: AuthProvider.of(context).auth
        ));
      }
    }
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2020),
    );
    return picked;
  }
}