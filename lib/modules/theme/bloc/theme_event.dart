part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  @override
  List<Object?> get props => [];
}
class InitializeThemeEvent extends ThemeEvent {
  @override
  List<Object?> get props => [];
}
