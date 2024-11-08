library event_bloc.dart;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/events/event.dart';
import 'package:gamers_hub/modules/models/events/event_logo.dart';
import 'package:gamers_hub/modules/models/events/event_network.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent,EventState>{
  EventBloc():super(EventState(isLoading: false, events: [], eventLogos: [], eventNetworks: [])){
    on<EventEventFetchEvents>(_onEventEventFetchEvents);
  }

  FutureOr<void> _onEventEventFetchEvents(EventEventFetchEvents event, Emitter<EventState> emit) {
    // api calls are set and now write the logic
  }
}