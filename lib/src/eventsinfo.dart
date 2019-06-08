import 'package:flutter/material.dart';

import 'appbloc.dart';
import 'authprovider.dart';
import 'eventdata.dart';
import 'utils.dart';

class EventsInfo extends StatefulWidget {
  @override
  _EventsInfoState createState() => _EventsInfoState();
}

class _EventsInfoState extends State<EventsInfo> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AuthProvider.of(context).appBloc.barChartStateNotifier,
      builder: (context, value, _) {
        if (value == BarChartStates.noData) {
          return Center(child: Text("No date selected. Please select dates.")); // select date message
        } else if(value == BarChartStates.dataFetching) {
          return Center(child: CircularProgressIndicator()); // circular progress indicator
        } else {
          return ListView.builder(
            itemCount: AuthProvider.of(context).appBloc.eventDatas.length,
            itemBuilder: (context, i) {
              EventData item = AuthProvider.of(context).appBloc.eventDatas[i];
              return Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  color: HexColor(item.color),
                  child: ListTile(
                    title: Text(item.summary),
                    subtitle: Text(item.numEvents.toString())
                  ),
                ),
              );
            }
          );
        }
      }
    );
  }
}