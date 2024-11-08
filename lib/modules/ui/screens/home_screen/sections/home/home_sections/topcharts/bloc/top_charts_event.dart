part of 'top_charts_bloc.dart';

abstract class TopChartsEvent{}

class TopChartsEventGetGames extends TopChartsEvent{
  TopChartsEventGetGames({required this.limit});
  
  final int limit;
}

class TopChartsEventFetchMoreGames extends TopChartsEvent{
  TopChartsEventFetchMoreGames();
}