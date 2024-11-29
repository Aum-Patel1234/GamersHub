library theme_bloc.dart;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc(): super(ThemeState(themeData: ThemeData.dark())){
    on<ToggleThemeEvent>(
      (event,emit) => emit(ThemeState(themeData: state.themeData == ThemeData.dark() ? ThemeData.light() : ThemeData.dark()))   
    );
  }
}