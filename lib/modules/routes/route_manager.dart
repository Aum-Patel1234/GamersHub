import 'package:flutter/material.dart';
import 'package:gamers_hub/modules/ui/screens/application.dart';
import 'package:gamers_hub/modules/ui/screens/auth/edit_user/edit_profile_screen.dart';
import 'package:gamers_hub/modules/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:gamers_hub/modules/ui/screens/game_screen/game_screen.dart';
import 'package:page_transition/page_transition.dart';

class RouteManager {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments as Map<String,dynamic>?;

    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(builder: (context) => const Application(),);
        }
      case '/signIn':
        {
          return MaterialPageRoute(builder: (context) => const SignInScreen());
        }
      case '/game':
        {
          if(args != null && args.containsKey('game') && args.containsKey('cover')) {
            return MaterialPageRoute(builder: (context) => GameScreen(game: args['game'],coverUrl: args['cover'],));
          }
        }
      case '/user-edit':
        {
          return PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const EditProfileScreen(),
            settings: settings,
          );
        }
    }
    
    return _errorRoute();
  }

  static Route<MaterialPageRoute> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => (Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error page',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: const Center(
          child: Text(
            'Some Error Occured !!',
            style: TextStyle(fontSize: 36),
          ),
        ),
      )),
    );
  }
}