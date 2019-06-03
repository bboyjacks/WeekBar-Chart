
class EventData {
  EventData({
    this.summary,
    this.numEvents,
  });

  final String summary;
  final int numEvents;
  String color;

  set backgroundColor(String backgroundColor) {
    color = backgroundColor;
  }
}

class EmptyEventData extends EventData {
  
}