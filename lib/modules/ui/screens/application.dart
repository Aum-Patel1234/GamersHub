import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/bottom_navigation_bar/bloc/bottom_navigation_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/events/bloc/event_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/topcharts/bloc/top_charts_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/src/home_screen.dart';
import 'auth/bloc/auth_bloc.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<AuthBloc>().add(AuthEventInitialize())
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context,state){
        // log(state.isAuthenticated.toString());
        if(state.isLoading){
          return const Center(child: CircularProgressIndicator());
        }
        if(state.isAuthenticated){
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => BottomNavigationBloc(),),
              BlocProvider(create: (context) => TopChartsBloc(),),
              BlocProvider(create: (context) => EventBloc(),),
            ],
            child: const HomeScreen(),
          );
        }
        return const SignInScreen();
      },
    );
  }
}