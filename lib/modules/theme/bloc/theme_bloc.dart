library theme_bloc.dart;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/utils/config/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _darkModeKey = 'darkMode';

  ThemeBloc() : super(ThemeState(themeData: ThemeData.dark())) {
    on<InitializeThemeEvent>(
      (event, emit) {
        var box = Hive.box(Config.myHiveBox);
        bool isDarkMode = box.get(_darkModeKey) as bool? ?? true;
        emit(ThemeState(themeData: isDarkMode ? ThemeData.light() : ThemeData.dark()));
      },
    );

    on<ToggleThemeEvent>((event, emit) {
      var box = Hive.box(Config.myHiveBox);
      ThemeState themeState = state.copyWith(themeData: state.themeData == ThemeData.dark() ? ThemeData.light() : ThemeData.dark());
      box.put(_darkModeKey, themeState.themeData == ThemeData.dark());  
      emit(themeState);
    });
  }
}
