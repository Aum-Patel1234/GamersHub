part of 'auth_bloc.dart';

class AuthState{
  AuthState({required this.isLoading, required this.isAuthenticated, this.userModel});

  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? userModel;

  AuthState copyWith({bool? isLoading,bool? isAuthenticated,UserModel? user,}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userModel: user ?? userModel,
    );
  }
}