library theme_bloc.dart;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/utils/config/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc(): super(ThemeState(themeData: ThemeData.dark())){
    on<ToggleThemeEvent>(
      (event,emit){
        const darkModeKey = 'darkMode';
        var box = Hive.box(Config.myHiveBox);
        bool? isDarkMode = box.get(darkModeKey) as bool?;

        if(isDarkMode == null){
          box.put(darkModeKey, true);
          isDarkMode = true;
        }else{
          isDarkMode = !isDarkMode;
          box.put(darkModeKey, isDarkMode);
        }
        
        emit(ThemeState(themeData: isDarkMode ? ThemeData.light() : ThemeData.dark()));
      }
    );
  }
}