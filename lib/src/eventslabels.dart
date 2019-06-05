import 'package:flutter/material.dart';
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
      shrinkWrap: true,
      itemCount: calendarEventsData.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0
          ),
          child: Container(
            color: HexColor(calendarEventsData[index].color),
            child: EventLabelListTile(calendarEventsData[index])),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLabels(calendarEventsData);
  }
}

class EventLabelListTile extends ListTile {
  EventLabelListTile(EventData eventData)
      : super(
    title: Text(eventData.summary),
    subtitle: Text(eventData.numEvents.toString()),
    dense: true
  );
}
