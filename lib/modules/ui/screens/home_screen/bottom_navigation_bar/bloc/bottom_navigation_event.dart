part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent{}

class BottomNavigationEventOnChanged extends BottomNavigationEvent{
  final int index;

  BottomNavigationEventOnChanged({required this.index});
}