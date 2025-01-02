part of 'categories_bloc.dart';

class CategoriesState {
  final bool isLoading;
  final List<Genre> genres;

  CategoriesState({required this.isLoading, required this.genres});

  CategoriesState copyWith({
    bool? isLoading,
    List<Genre>? genres
  }){
    return CategoriesState(isLoading: isLoading ?? this.isLoading, genres: genres ?? this.genres);
  }
}