import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/routes/route_manager.dart';
import 'package:gamers_hub/modules/theme/bloc/theme_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/application.dart';
import 'package:gamers_hub/utils/global_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,state) => MaterialApp(
          onGenerateRoute: RouteManager.generateRoutes,
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: state.themeData,
          debugShowCheckedModeBanner: false,
          home: const Application(),
        ),
      ),
    );
  }
}