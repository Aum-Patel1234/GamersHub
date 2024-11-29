library bottom_navigation_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent,BottomNavigationState>{
  BottomNavigationBloc():super(BottomNavigationState(index: 0)){
    on<BottomNavigationEventOnChanged>(_onBottomNavigationEventOnChanged);
  }

  void _onBottomNavigationEventOnChanged(BottomNavigationEventOnChanged event, Emitter<BottomNavigationState> emit) {
    emit(BottomNavigationState(index: event.index));
  }
}