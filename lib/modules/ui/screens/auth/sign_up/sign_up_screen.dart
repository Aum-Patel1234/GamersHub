import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/auth/bloc/auth_bloc.dart';

import '../../../../../utils/config/config.dart';
import '../shared/auth_shared_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocListener<AuthBloc,AuthState>(      
      listener: (context,state){
          if(state.isAuthenticated){
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      child: Scaffold(
        resizeToAvoidBottomInset: false,    // important as it avoids the background to change when it enters something in textfield
        body: Stack(
          children: [
            Positioned(
              left: 10,
              top: 40,
              child: IconButton.outlined(
                icon: const Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
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
                          'Create New Account',
                          style: TextStyle(
                            fontSize: 28,
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
      
                      const SizedBox(height: 20,),
                      
                      SigninSignupButton(text: 'Sign Up',emailKey: _emailKey,emailcontroller: _emailcontroller,passwordcontroller: _passwordcontroller,),
                      
                      const Padding(
                        padding: EdgeInsets.all(Config.paddingEight),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
      
                      const SignInAsGuestButton(),
                    ],
                  ),
                ),
              ),
            )
          ],
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
