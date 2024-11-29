import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/theme/bloc/theme_bloc.dart';
import '../modules/ui/screens/auth/bloc/auth_bloc.dart';

class GlobalProviders extends StatelessWidget {
  const GlobalProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ThemeBloc(),),
      ],
      child: child,
    );
  }
}