library top_charts_bloc.dart;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/covers/cover.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/service/home_page_api_service.dart';

part 'top_charts_event.dart';
part 'top_charts_state.dart';

class TopChartsBloc extends Bloc<TopChartsEvent,TopChartsState>{
  TopChartsBloc():super(TopChartsState(isLoading: false, popularGames: [], covers: [])){
    on<TopChartsEventGetGames>(_onTopChartsEventGetGames);
    on<TopChartsEventFetchMoreGames>(_onTopChartsEventFetchMoreGames);
  } 
  
  final HomePageApiService _service = HomePageApiService();
  static const int _end = 200;

  FutureOr<void> _onTopChartsEventGetGames(TopChartsEventGetGames event, Emitter<TopChartsState> emit) async{
    emit(state.copyWith(isLoading: true));

    final List<Games>? games = await _service.getTopChartsGames(offset: 0,limit: event.limit);
    if(games == null){
      emit(state.copyWith(isLoading: false));
      return;             // if the state in the games do not increase that means some error occure which will be shown by snackbar
    }
    state.popularGames.addAll(games);

    final List<Cover>? covers = await _service.getCovers(games: games);
    if(covers == null){
      emit(state.copyWith(isLoading: false));
      return;
    }
    state.covers.addAll(covers);

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onTopChartsEventFetchMoreGames(TopChartsEventFetchMoreGames event, Emitter<TopChartsState> emit) async{
    emit(state.copyWith(isLoading: true));

    if(state.popularGames.length + 6 < _end){
      final List<Games>? games = await _service.getTopChartsGames(offset: state.popularGames.length,limit: 10);

      if(games != null){
        state.popularGames.addAll(games);
        final List<Cover>? covers = await _service.getCovers(games: games);

        if(covers != null){
          state.covers.addAll(covers);
        }
      }
    }

    emit(state.copyWith(isLoading: false));
  }
}