part of 'auth_shared_widgets.dart';

enum SignInCompany{
  google,
  facebook,
  twitter;
}

class CompanySignInButton extends StatelessWidget {
  const CompanySignInButton({
    super.key, required this.imageLink, required this.signInCompany,
  });

  final String imageLink;
  final SignInCompany signInCompany;

  @override
  Widget build(BuildContext context) {
    // Color lighterColor = Color.alphaBlend(Colors.black.withOpacity(0.2), Theme.of(context).scaffoldBackgroundColor);
    final Color boxColor = (context.read<ThemeBloc>().state.themeData == ThemeData.dark()) 
        ? Colors.white24
        : Colors.black12;

    return GestureDetector(
      onTap: (){
        if(signInCompany == SignInCompany.google){
          context.read<AuthBloc>().add(AuthEventGoogleSignIn());
        }else if(signInCompany == SignInCompany.facebook){
          context.read<AuthBloc>().add(AuthEventFacebookSignIn());
        }else{
          context.read<AuthBloc>().add(AuthEventTwitterSignIn());
        }
      },
      child: Container(
        padding: const EdgeInsets.all(Config.paddingEight),
        margin: const EdgeInsets.all(Config.marginEight),
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(Config.borderRadius),
        ),
        child: Center(
          child: Image.asset(imageLink,width: 25,height: 25,),
        ),
      ),
    );
  }
}