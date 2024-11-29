part of 'home_screen_appbar.dart';

class MygamesAppbar extends StatelessWidget {
  const MygamesAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          const Image(
            image: AssetImage("assets/images/logo.png"),
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 10),
          const Text(
            'My Games',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // Handle search action
            },
            icon: const Icon(
              CupertinoIcons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle info action
            },
            icon: const Icon(
              Icons.info,
            ),
          ),
        ],
      ),
    );
  }
}