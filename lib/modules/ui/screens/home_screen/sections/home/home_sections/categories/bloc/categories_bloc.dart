import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/genres/genre.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/categories/service/genre_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent,CategoriesState> {
  CategoriesBloc():super(CategoriesState(isLoading: false, genres: [])){
    on<CategoriesEventGetGenres>(_onCategoriesEventGetGenres);
  }
  /*
    https://www.igdb.com/genres/point-and-click is the link of the specific genre so it can be genralised - https://www.igdb.com/genres/${slug} 
  */

  final GenreService _service = GenreService();

  FutureOr<void> _onCategoriesEventGetGenres(CategoriesEventGetGenres event, Emitter<CategoriesState> emit) async{
    emit(state.copyWith(isLoading: true));


    List<Genre>? genre = await _service.getGenres();

    emit(state.copyWith(isLoading: false));
  }
}