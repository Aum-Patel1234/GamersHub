import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/genres/genre.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/categories/service/genre_service.dart';
import 'package:gamers_hub/utils/config/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    bool shouldUpdate = true;
    var box = Hive.box(Config.myHiveBox);
    String? genreCreationTimeinSeconds = box.get('genreCreationTimeinSeconds');
    if(genreCreationTimeinSeconds != null){
      DateTime now = DateTime.now();
      DateTime lastTimeUpdated = DateTime.parse(genreCreationTimeinSeconds);

      if(now.difference(lastTimeUpdated).inDays <= 15){                            // update in a span of 15 days 
        // If the data was updated in the last 15 days, skip fetching new data
        shouldUpdate = false;
      }
    }

    if(!shouldUpdate){
      List<String>? storedGenres = box.get('genres') as List<String>?;
      if(storedGenres != null){
        List<Genre> tempGenres = _fromHive(storedGenres);
        // log('hive stored data - ${tempGenres.toString()}'); 
        emit(state.copyWith(isLoading: false,genres: tempGenres));
        return;
      }
    }

    List<Genre>? genres = await _service.getGenres();
    if(genres == null){
      emit(state.copyWith(isLoading: false)); // Ensure loading is turned off
      return;
    }

    // box.delete('genres');
    List<String> genreSlugs = genres.map((genre) => genre.slug).toList(); // Create a list of slugs
    box.put('genres', genreSlugs); // Store it as a list of strings

    box.put('genreCreationTimeinSeconds', DateTime.now().toString());
    // log(genres.toString());
    emit(state.copyWith(isLoading: false,genres: genres));
  }

  List<Genre> _fromHive(List<String> slugList){
    List<Genre> genres = [];

    for (String slug in slugList) {
      genres.add(Genre(slug: slug));
    }

    return genres;
  }
}