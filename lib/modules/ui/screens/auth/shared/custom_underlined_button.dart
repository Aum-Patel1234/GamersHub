part of 'auth_shared_widgets.dart';

class CustomUnderlinedButton extends StatelessWidget {
  const CustomUnderlinedButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == "Create a New Account") {
          // this is the only way a user can go to sign up screeen as there is not named route of it
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(Config.paddingEight),
        child: Text(
          text,
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
