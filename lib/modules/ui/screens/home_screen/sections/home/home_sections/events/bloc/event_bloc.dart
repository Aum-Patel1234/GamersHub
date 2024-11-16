library event_bloc.dart;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/events/event.dart';
import 'package:gamers_hub/modules/models/events/event_logo.dart';
import 'package:gamers_hub/modules/models/events/event_network.dart';
import 'package:gamers_hub/modules/service/home_page_api_service.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent,EventState>{
  EventBloc():super(EventState(isLoading: false, events: [], eventLogos: [], eventNetworks: [])){
    on<EventEventFetchEvents>(_onEventEventFetchEvents);
    on<EventEventFetchEventLogo>(_onEventEventFetchEventLogo);
    on<EventEventFetchEventNetwork>(_onEventEventFetchEventNetwork);
  }

  final HomePageApiService _apiService = HomePageApiService();

  FutureOr<void> _onEventEventFetchEvents(EventEventFetchEvents event, Emitter<EventState> emit) async{
    emit(state.copyWith(isLoading: true));

    List<Event>? events = await _apiService.getEvents(limit: event.limit,offset: 0);
    if(events != null){
      state.events.addAll(events);
      add(EventEventFetchEventLogo(events: events));
    }

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onEventEventFetchEventLogo(EventEventFetchEventLogo event, Emitter<EventState> emit) async{
    emit(state.copyWith(isLoading: true));
    
    List<EventLogo?>? eventLogos = await _apiService.getEventLogos(events: event.events);
    if(eventLogos != null){
      state.eventLogos.addAll(eventLogos);
      if (eventLogos.length != event.events.length) {
        final int missingCount = event.events.length - eventLogos.length;
        state.eventLogos.addAll(List.generate(missingCount, (_) => null));  // Add 'null' or placeholder values where logo is not available
        // log(state.eventLogos.toString());
      }
    }else{
      for (int i = 0; i < event.events.length; i++) {
        state.eventLogos.add(null);
      }
    }

    emit(state.copyWith(isLoading: false));  
  }

  FutureOr<void> _onEventEventFetchEventNetwork(EventEventFetchEventNetwork event, Emitter<EventState> emit) async{
    emit(state.copyWith(isLoading: true));
    
    List<EventNetwork>? eventNetworks = await _apiService.getEventNewtworks(events: event.events);
    if(eventNetworks != null){
      state.eventNetworks.addAll(eventNetworks);
    }else{
      for (int i = 0; i < event.events.length; i++) {
        state.eventNetworks.add(null);
      }
    }

    emit(state.copyWith(isLoading: false));  
  }
}