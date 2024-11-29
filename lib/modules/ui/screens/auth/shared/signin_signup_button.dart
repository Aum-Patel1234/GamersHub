part of 'auth_shared_widgets.dart';

class SigninSignupButton extends StatelessWidget {
  const SigninSignupButton(
      {super.key,
      required this.text,
      required this.emailKey,
      required this.emailcontroller,
      required this.passwordcontroller});

  final String text;
  final GlobalKey<FormState> emailKey;
  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, Config.paddingSixteen, 0, Config.paddingSixteen),
      child: Center(
        child: Container(
          width: width * 0.8,
          decoration: BoxDecoration(
            color: const Color(ColorConfig.submitButtonGreen),
            borderRadius: BorderRadius.circular(Config.borderRadiusDeep),
          ),
          child: TextButton(
            onPressed: () {
              if (emailKey.currentState!.validate()) {
                if (text == "Sign Up") {
                  context.read<AuthBloc>().add(AuthEventSignUp(email: emailcontroller.text,password: passwordcontroller.text,));
                } else {
                  context.read<AuthBloc>().add(AuthEventSignIn(email: emailcontroller.text,password: passwordcontroller.text));
                }
              }
            },
            style: TextButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              overlayColor: const Color(ColorConfig.submitButtonSplashGreen),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(ColorConfig.colorWhite),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
