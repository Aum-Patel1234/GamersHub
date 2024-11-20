part of 'top_charts_bloc.dart';

class TopChartsState {
  final bool isLoading;
  List<Games> popularGames;
  Map<int,Cover> covers; 

  TopChartsState({required this.isLoading,required this.popularGames,required this.covers});

  TopChartsState copyWith({
    bool? isLoading,
    List<Games>? popularGames,
    Map<int,Cover>? covers,
  }) {
    return TopChartsState(
      isLoading: isLoading ?? this.isLoading,
      popularGames: popularGames ?? this.popularGames,
      covers: covers ?? this.covers,
    );
  }
}