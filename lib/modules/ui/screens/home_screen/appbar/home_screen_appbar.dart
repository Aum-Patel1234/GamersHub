library home_screen_appbar.dart;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/auth/bloc/auth_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/bottom_navigation_bar/bloc/bottom_navigation_bloc.dart';

part 'home_body_appbar.dart';
part 'mygames_appbar.dart';
part 'settings_appbar.dart';
part 'wishlist_appbar.dart';

class HomeScreenAppbar extends StatelessWidget{
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc,BottomNavigationState>(
      builder: (context,state){
        switch(state.index){
          case 0: return const HomeBodyAppbar();
          case 1: return const GameVerseAppbar();
          case 2: return const MygamesAppbar();
          default: return const SettingsAppbar();
        }
      },
    );
  }
}