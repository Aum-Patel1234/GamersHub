library top_charts_bloc.dart;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/covers/cover.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/service/common_service.dart';
import 'package:gamers_hub/modules/service/home_page_api_service.dart';

part 'top_charts_event.dart';
part 'top_charts_state.dart';

class TopChartsBloc extends Bloc<TopChartsEvent,TopChartsState>{
  TopChartsBloc():super(TopChartsState(isLoading: false, popularGames: [], covers: {})){
    on<TopChartsEventGetGames>(_onTopChartsEventGetGames);
    on<TopChartsEventGetCovers>(_onTopChartsEventGetCovers);
  } 
  
  final HomePageApiService _service = HomePageApiService();
  final CommonService _commonService = CommonService();
  static const int _end = 200;

  FutureOr<void> _onTopChartsEventGetGames(TopChartsEventGetGames event, Emitter<TopChartsState> emit) async{
    emit(state.copyWith(isLoading: true));

    if(state.popularGames.length + 6 > _end){
      emit(state.copyWith(isLoading: false));
      return;                                         // popular games have a limit of 200
    }

    final List<int>? popularGames = await _service.getPopularityPrimitive(offset: state.popularGames.length, limit: event.limit);

    if(popularGames == null){
      emit(state.copyWith(isLoading: false));
      return;             // if the state in the games do not increase that means some error occure which will be shown by snackbar
    }

    final List<Games>? games = await _commonService.getGames(gameIds: popularGames);
    if(games == null){
      emit(state.copyWith(isLoading: false));
      return;             // if the state in the games do not increase that means some error occure which will be shown by snackbar
    }
    state.popularGames.addAll(games);

    // final List<Cover>? covers = await _service.getCovers(games: games);
    // if(covers == null){
    //   emit(state.copyWith(isLoading: false));
    //   return;
    // }
    // state.covers.addAll(covers);
    add(TopChartsEventGetCovers(gameIds: games.map((game) => game.cover).nonNulls.toList())); // nonNulls help to remove all nuls and the map will b null freee

    emit(state.copyWith(isLoading: false));
  }

  // FutureOr<void> _onTopChartsEventFetchMoreGames(TopChartsEventFetchMoreGames event, Emitter<TopChartsState> emit) async{
  //   emit(state.copyWith(isLoading: true));

  //   if(state.popularGames.length + 6 < _end){
  //     final List<Games>? games = await _service.getTopChartsGames(offset: state.popularGames.length,limit: 10);

  //     if(games != null){
  //       state.popularGames.addAll(games);

  //       add(TopChartsEventGetCovers(gameIds: games.map((game) => game.cover).nonNulls.toList()));
  //     }
  //   }

  //   emit(state.copyWith(isLoading: false));
  // }

  FutureOr<void> _onTopChartsEventGetCovers(TopChartsEventGetCovers event, Emitter<TopChartsState> emit) async{
    // final List<Cover>? covers = await _service.getCovers(gameId: event.gameIds,parameter: "id");
    final List<Cover>? covers = await _commonService.getCovers(coverIds: event.gameIds,parameter: "id");
    
    if(covers == null)    return;
    
    for (Cover cover in covers) {
      state.covers[cover.game] = cover;
    }
  }
}