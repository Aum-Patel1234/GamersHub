part of 'event_bloc.dart';

abstract class EventEvent{}

class EventEventFetchEvents extends EventEvent{
  final int limit;

  EventEventFetchEvents({required this.limit});
}
class EventEventFetchEventLogo extends EventEvent{
  final List<Event> events;

  EventEventFetchEventLogo({required this.events});
}
class EventEventFetchEventNetwork extends EventEvent{
  final List<Event> events;

  EventEventFetchEventNetwork({required this.events});
}