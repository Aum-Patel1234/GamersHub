import 'package:flutter/material.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/ui/screens/application.dart';
import 'package:gamers_hub/modules/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:gamers_hub/modules/ui/screens/game_screen/game_screen.dart';

class RouteManager {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;

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
          if(args is Games) {
            return MaterialPageRoute(builder: (context) => GameScreen(game: args,));
          }
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
