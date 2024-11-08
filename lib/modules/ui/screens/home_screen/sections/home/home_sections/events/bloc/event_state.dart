part of 'event_bloc.dart';

class EventState {
  final bool isLoading;
  List<Event> events;
  List<EventLogo> eventLogos;
  List<EventNetwork> eventNetworks;

  EventState({
    required this.isLoading,
    required this.events,
    required this.eventLogos,
    required this.eventNetworks,
  });

  // The copyWith method
  EventState copyWith({
    bool? isLoading,
    List<Event>? events,
    List<EventLogo>? eventLogos,
    List<EventNetwork>? eventNetworks,
  }) {
    return EventState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      eventLogos: eventLogos ?? this.eventLogos,
      eventNetworks: eventNetworks ?? this.eventNetworks,
    );
  }
}