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
  EventBloc():super(EventState(isLoading: false, events: [], eventLogos: {}, eventNetworks: {})){
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
    
    List<EventLogo>? eventLogos = await _apiService.getEventLogos(events: event.events);
    if(eventLogos != null){
      for(EventLogo eventLogo in eventLogos){
        state.eventLogos[eventLogo.event] = eventLogo;    // put id:logo i.e we can get id from the list<event> in the state
      }
    }

    emit(state.copyWith(isLoading: false));  
  }

  FutureOr<void> _onEventEventFetchEventNetwork(EventEventFetchEventNetwork event, Emitter<EventState> emit) async{
    emit(state.copyWith(isLoading: true));
    
    // List<EventNetwork>? eventNetworks = await _apiService.getEventNewtworks(events: event.events);
    // if(eventNetworks != null){
    //   state.eventNetworks.addAll(eventNetworks);
    // }else{
    //   for (int i = 0; i < event.events.length; i++) {
    //     state.eventNetworks.add(null);
    //   }
    // }

    emit(state.copyWith(isLoading: false));  
  }
}