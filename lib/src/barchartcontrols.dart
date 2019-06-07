
import 'package:flutter/material.dart';
import 'appbloc.dart';
import 'authprovider.dart';
import 'daterange.dart';
import 'eventdata.dart';
import 'eventslabels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarChartControls extends StatefulWidget {
  BarChartControls(
    {
      this.calendarEventsData,
      void Function(DateTime start, DateTime end) dateAction
    }
  ): dateAction = dateAction;
  final List<EventData> calendarEventsData;
  final void Function(DateTime start, DateTime end) dateAction;

  @override
  _BarChartControlsState createState() => _BarChartControlsState();
}

class _BarChartControlsState extends State<BarChartControls> {
  DateTime startTime;
  DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              Flexible(
                child: EventsLabel(
                  calendarEventsData: widget.calendarEventsData
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _controllButton(
                      icon: Icon(FontAwesomeIcons.sun, color: Colors.white,),
                      text: Text("Start", style: TextStyle(color: Colors.white),),
                      context: context
                    ),
                    SizedBox(height: 20,),
                    _controllButton(
                      icon: Icon(FontAwesomeIcons.moon, color: Colors.white),
                      text: Text("End", style: TextStyle(color: Colors.white),),
                      context: context
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void _selectDate(BuildContext context, Text text) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2020)
    );
    if(picked != null) {
      if (text.data == "Start") {
        startTime = picked;
      } else if (text.data == "End") {
        endTime = picked;
      }

      if (startTime != null && endTime != null) {
        if (startTime.isAfter(endTime)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Date Error"),
                content: Text('''Start time is after end time. Make
                  sure the start time is before end time'''),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
          );
        }
        else {
          AppBloc appBloc = AuthProvider.of(context).appBloc;
          appBloc.calendarEventsStreamSink.add(DateRange(
            start: startTime,
            end: endTime,
            auth: AuthProvider.of(context).auth
          ));
        }
      }
    }
  }

  Center _controllButton({Icon icon, Widget text, BuildContext context}) {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              icon,
              text
            ],
          ),
        ),
        onPressed: (){_selectDate(context, text);},
      ),
    );
  }
}