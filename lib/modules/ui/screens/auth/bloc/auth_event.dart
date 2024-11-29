part of 'auth_bloc.dart';

abstract class AuthEvent{}

class AuthEventInitialize extends AuthEvent{}

class AuthEventSignIn extends AuthEvent{
  final String email;
  final String password;

  AuthEventSignIn({required this.email, required this.password});
}

class AuthEventSignUp extends AuthEvent{
  final String email;
  final String password;

  AuthEventSignUp({required this.email, required this.password});
}

class AuthEventSignInAsGuest extends AuthEvent{}

class AuthEventLogout extends AuthEvent{}

class AuthEventCreateUser extends AuthEvent{
  AuthEventCreateUser({required this.userModel});

  final UserModel userModel;
}

class AuthEventGoogleSignIn extends AuthEvent{}
class AuthEventFacebookSignIn extends AuthEvent{}
class AuthEventTwitterSignIn extends AuthEvent{}