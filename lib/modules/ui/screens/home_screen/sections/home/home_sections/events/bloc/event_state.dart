part of 'event_bloc.dart';

class EventState {
  final bool isLoading;
  final List<Event> events;
  final Map<int, EventLogo> eventLogos;
  final Map<int, EventNetwork> eventNetworks;

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
    Map<int, EventLogo>? eventLogos,
    Map<int, EventNetwork>? eventNetworks,
  }) {
    return EventState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      eventLogos: eventLogos ?? this.eventLogos,
      eventNetworks: eventNetworks ?? this.eventNetworks,
    );
  }
}