import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'eventdata.dart';
import 'utils.dart';

class EventsLabel extends StatelessWidget {
  EventsLabel(
    {
      this.calendarEventsData
    }
  );
  final List<EventData> calendarEventsData;


  Widget _buildLabels(List<EventData> calendarEventsData) {
    return ListView.builder(
      itemCount: calendarEventsData.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: HexColor(calendarEventsData[index].color),
          child: Expanded(
            child: EventLabelListTile(calendarEventsData[index])
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double chartHeight = AuthProvider.of(context).barChartHeight;
    // double chartWidth = AuthProvider.of(context).barChartWidth;
    return _buildLabels(calendarEventsData);
  }
}

class EventLabelListTile extends ListTile {
  EventLabelListTile(EventData eventData)
      : super(
    title: Text(eventData.summary),
    subtitle: Text(eventData.numEvents.toString())
  );
}
