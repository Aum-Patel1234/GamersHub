import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/bottom_navigation_bar/bloc/bottom_navigation_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/gameverse/game_verse.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/categories/bloc/categories_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/home_section_collection.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/topcharts/bloc/top_charts_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/my_games/my_games.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/settings/settings_body.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/widgets/home_screen_widgets.dart';
import '../appbar/home_screen_appbar.dart';
import '../sections/home/home_sections/events/bloc/event_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ScrollController _topChartsScrollController = ScrollController();
  final ScrollController _eventsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TopChartsBloc>().add(TopChartsEventGetGames(limit: 15,));
        context.read<EventBloc>().add(EventEventFetchEvents(limit: 10));
        context.read<CategoriesBloc>().add(CategoriesEventGetGenres());
      }
    });
    handleControllers();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            const HomeScreenAppbar(),                 // custom appbar

            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<BottomNavigationBloc>().add(BottomNavigationEventOnChanged(index: index));
                },
                children: [
                   TabBarView(
                    children: [
                      const Center(child: Text('For You Content')),
                      TopCharts(scrollController: _topChartsScrollController),
                      Events(scrollController: _eventsScrollController,),
                      // const Center(child: Text('Kids content')),   
                      const Categories(),
                    ],
                  ),
                  const GameVerse(),
                  const MyGames(),
                  const SettingsBody(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(pageController: _pageController),
      ),
    );
  }

  void handleControllers(){
    _topChartsScrollController.addListener((){
      if(!context.read<TopChartsBloc>().state.isLoading && _topChartsScrollController.position.pixels >= _topChartsScrollController.position.maxScrollExtent*0.9){    // Trigger pagination when the user scrolls near the end
        // !context.read<TopChartsBloc>().state.isLoading   -> this helps to prevent multiple requests to the sever at once
        context.read<TopChartsBloc>().add(TopChartsEventGetGames(limit: 10));
      } 
    });
    
    _eventsScrollController.addListener((){
      if(!context.read<EventBloc>().state.isLoading && _eventsScrollController.position.pixels >= _eventsScrollController.position.maxScrollExtent*0.9){
        context.read<EventBloc>().add(EventEventFetchEvents(limit: 10));
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _topChartsScrollController.dispose();
    _eventsScrollController.dispose();
    super.dispose();
  }
}
