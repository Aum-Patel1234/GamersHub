part of 'home_screen_appbar.dart';

class SettingsAppbar extends StatelessWidget {
  const SettingsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10,bottom: 10),
      child: Row(
        children: [
          const Image(
            image: AssetImage("assets/images/logo.png"),
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 10),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // Handle info action
            },
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}