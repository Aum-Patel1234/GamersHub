import 'package:flutter/material.dart';

import '../../../../../utils/config/config.dart';
import '../shared/auth_shared_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,    // important as it avoids the background to change when it enters something in textfield
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(Config.paddingEight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(Config.paddingEight),
                  child: Image(
                    width: 100,                                                     // constant width
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(Config.paddingSixteen),
                  child: Text(
                    'Login to Your Account',
                    style: TextStyle(
                      fontSize: 26,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: _emailKey,
                  child: CustomSigninSignupTextfield(
                    controller: _emailcontroller,
                    hintText: "Enter Your Email",
                  ),
                ),
                CustomSigninSignupTextfield(
                  controller: _passwordcontroller,
                  hintText: "Enter Your Password",
                  obscureText: true,
                ),
      
                SizedBox(
                  height: height * 0.02,
                ),
      
                const Align(
                  alignment: Alignment.centerRight,
                  child: CustomUnderlinedButton(
                    text: 'Forgot Password?',
                  ),
                ),
      
                SigninSignupButton(text: 'Sign In',emailKey: _emailKey,emailcontroller: _emailcontroller,passwordcontroller: _passwordcontroller,),

                const Padding(
                  padding: EdgeInsets.all(Config.paddingSixteen),
                  child: CustomDivider(),
                ),
      
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CompanySignInButton(
                      imageLink: 'assets/icons/google_icon.png',
                      signInCompany: SignInCompany.google,
      
                    ),
                    CompanySignInButton(
                      imageLink: 'assets/icons/facebook.png',
                      signInCompany: SignInCompany.facebook,
                    ),
                    CompanySignInButton(
                      imageLink: 'assets/icons/logo-white.png',
                      signInCompany: SignInCompany.twitter,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: CustomUnderlinedButton(text: 'Create a New Account'),  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
}
