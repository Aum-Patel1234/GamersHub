part of 'settings_body.dart';

void customAboutDialog(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationName: "GamersHub",
    applicationIcon: const Image(
      image: AssetImage("assets/images/logo.png"),
      width: 50,
      height: 50,
    ),
    applicationVersion: "Version 1.0.0",
    children: [
      const SizedBox(height: 16), // Space before legalese
      const Text(
        "© 2024 GamersHub. All rights reserved.",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8), // Space after legalese
      const Text(
        "GamersHub is a platform dedicated to connecting gamers and providing "
        "a space for sharing experiences, tips, and gaming news. By using our "
        "app, you agree to our Terms of Service and Privacy Policy.",
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16), // Space before support contact
      const Text(
        "For support or inquiries, please contact us at:\n"
        "support@gamershub.com",
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16), // Space before social media section
      const Text(
        "Stay Connected:\n"
        "Follow us on social media for the latest updates and community events!",
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8), // Space after the text
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.facebook),
            onPressed: () {
              // Handle Facebook link
            },
          ),
          IconButton(
            icon: const Image(image: AssetImage("assets/icons/google_icon.png"),width: 20,height: 20,),
            onPressed: () {
              // Handle Twitter link
            },
          ),
          IconButton(
            icon: Image(image: AssetImage((context.read<ThemeBloc>().state.themeData == ThemeData.dark()) ? "assets/icons/logo-white.png" : "assets/icons/logo-black.png"),width: 20,height: 20,),
            onPressed: () {
              // Handle Instagram link
            },
          ),
        ],
      ),
    ],
  );
}
