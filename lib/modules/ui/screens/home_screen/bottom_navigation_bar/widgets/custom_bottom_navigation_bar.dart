part of '../../widgets/home_screen_widgets.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key, required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc,BottomNavigationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            // color: Colors.amber,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: NavigationBar(
            selectedIndex: state.index,
            backgroundColor: Colors.transparent,
            onDestinationSelected: (int index) {
              context.read<BottomNavigationBloc>().add(BottomNavigationEventOnChanged(index: index));
              pageController.jumpToPage(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
                tooltip: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.category_outlined),
                selectedIcon: Icon(Icons.category_rounded),
                label: 'GameVerse',
                tooltip: 'Multiverse of Games',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                selectedIcon: Icon(Icons.shopping_bag_rounded),
                label: 'My Games',
                tooltip: 'My Games',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
                tooltip: 'Settings',
              ),
            ],
          ),
        );
      }
    );
  }
}