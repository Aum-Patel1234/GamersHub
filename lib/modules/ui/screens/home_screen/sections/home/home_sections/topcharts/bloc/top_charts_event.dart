part of 'top_charts_bloc.dart';

abstract class TopChartsEvent{}

class TopChartsEventGetGames extends TopChartsEvent{
  TopChartsEventGetGames({required this.limit,});
  
  final int limit;
}
class TopChartsEventGetCovers extends TopChartsEvent{
  TopChartsEventGetCovers({required this.gameIds});
  
  final List<int> gameIds;
}