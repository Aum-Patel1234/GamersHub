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
class AuthEventUpdateUserInfo extends AuthEvent{
  final Map<String,dynamic> updatedFields;
  final String id;

  AuthEventUpdateUserInfo({required this.updatedFields, required this.id});
}
class AuthEventUpdateUserImg extends AuthEvent{
  final String filePath;

  AuthEventUpdateUserImg({required this.filePath});
}