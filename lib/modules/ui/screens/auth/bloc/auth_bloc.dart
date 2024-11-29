import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/service/auth_service.dart';
import 'package:gamers_hub/modules/service/game_auth_bearer_token_service.dart';
import 'package:gamers_hub/modules/ui/shared/show_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/user/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthState(isLoading: false, isAuthenticated: false)){
    on<AuthEventInitialize>(_onAuthEventInitialize);
    on<AuthEventSignIn>(_onAuthEventSignIn);
    on<AuthEventSignUp>(_onAuthEventSignUp);
    on<AuthEventSignInAsGuest>(_onAuthEventSignInAsGuest);
    on<AuthEventLogout>(_onAuthEventLogout);
    on<AuthEventCreateUser>(_onAuthEventCreateUser);
    on<AuthEventGoogleSignIn>(_onAuthEventGoogleSignIn);
    on<AuthEventFacebookSignIn>(_onAuthEventFacebookSignIn);
    on<AuthEventTwitterSignIn>(_onAuthEventTwitterSignIn);
  }
  
  final AuthService _authService = AuthService();

  FutureOr<void> _onAuthEventInitialize(AuthEventInitialize event, Emitter<AuthState> emit)async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const String accessToken = "access_token";
    if(prefs.getString(accessToken) == null){
      GameAuthBearerTokenService service = GameAuthBearerTokenService();
      prefs.setString(accessToken,await service.getBearerToken());                    // get and set the accessToken if it is expires automatically
    }
    log(prefs.getString(accessToken)!);
    final response = _authService.isAuthenticated;
    return emit.forEach(response, onData: (isAuthenticated){       
      return state.copyWith(isAuthenticated: isAuthenticated, user: _authService.currentUser);
    });
  }

  FutureOr<void> _onAuthEventSignIn(AuthEventSignIn event, Emitter<AuthState> emit) async{
    emit(state.copyWith(isLoading: true));
  
    final response = await _authService.signInWithEmailAndPassword(email: event.email, password: event.password);
    response.fold((l)async{
      emit(state.copyWith(isLoading: false,isAuthenticated: false));
      await showCustomSnackBar(message: "Login Unsuccessful");
    }, (r) async{
      emit(state.copyWith(isLoading: false,isAuthenticated: true,user: _authService.currentUser));
      await showCustomSnackBar(message: "Login Successful!");
    });
  }

  FutureOr<void> _onAuthEventSignUp(AuthEventSignUp event, Emitter<AuthState> emit) async{
    emit(state.copyWith(isLoading: true));

    final response = await _authService.createUserWithEmailAndPassword(email: event.email, password: event.password);

    response.fold(
    (l){
      showCustomSnackBar(message: l);
      emit(state.copyWith(isLoading: false,isAuthenticated: false)); // emit unsuccessfull state 
    },(r){
      add(
        AuthEventCreateUser(
          userModel: UserModel(
            id: r.user?.uid ?? '',
            email: r.user!.email ?? event.email,             // added a new event to create user
            username: r.user?.displayName ?? event.email.split("@")[0],
            profilePicture: r.user?.photoURL,
            phoneNumber: r.user?.phoneNumber,
          ),
        ),
      );
      showCustomSnackBar(message: "Account Created Successfully!");
      emit(state.copyWith(isLoading: false, isAuthenticated: true, user: _authService.currentUser)); // emit successfull state
    });
  }

  FutureOr<void> _onAuthEventSignInAsGuest(AuthEventSignInAsGuest event, Emitter<AuthState> emit) async{
    
  }

  FutureOr<void> _onAuthEventLogout(AuthEventLogout event, Emitter<AuthState> emit) async{
    emit(state.copyWith(isLoading: true));
    await _authService.logout();
    showCustomSnackBar(message: "Logout Successfull");
    emit(state.copyWith(isLoading: false,isAuthenticated: false));
  }

  FutureOr<void> _onAuthEventCreateUser(AuthEventCreateUser event, Emitter<AuthState> emit) async{
    await _authService.createUser(userModel: event.userModel);
    // the user model is not constructed in firebase i.e  not users collection is made and usermodel.map() is not made in firebase 
  } 

  FutureOr<void> _onAuthEventGoogleSignIn(AuthEventGoogleSignIn event, Emitter<AuthState> emit) async{
    // emit(state.copyWith(isLoading: true));
    final response = await _authService.googleSignIn();

    response.fold(
    (l){
      showCustomSnackBar(message: l);
      emit(state.copyWith(isLoading: false,isAuthenticated: false)); // emit unsuccessfull state 
    },(r){
      add(
        AuthEventCreateUser(
          userModel: UserModel(
            id: r.user?.uid ?? '',
            email: r.user!.email ?? '',
            username: r.user?.displayName ?? r.user!.email!.split("@")[0],
            profilePicture: r.user?.photoURL,
            phoneNumber: r.user?.phoneNumber,
          ),
        ),
      );
      showCustomSnackBar(message: "Google Sign in Completed!");
      emit(state.copyWith(isLoading: false, isAuthenticated: true, user: _authService.currentUser)); // emit successfull state
    });
  }

  FutureOr<void> _onAuthEventTwitterSignIn(AuthEventTwitterSignIn event, Emitter<AuthState> emit) async{
    // emit(state.copyWith(isLoading: true));
    final response = await _authService.signInWithTwitter();

    response.fold(
    (l){
      showCustomSnackBar(message: l);
      emit(state.copyWith(isLoading: false,isAuthenticated: false)); // emit unsuccessfull state 
    },(r){
      add(
        AuthEventCreateUser(
          userModel: UserModel(
            id: r.user?.uid ?? '',
            email: r.user!.email ?? '',
            username: r.user?.displayName ?? r.user!.email!.split("@")[0],
            profilePicture: r.user?.photoURL,
            phoneNumber: r.user?.phoneNumber,
          ),
        ),
      );
      showCustomSnackBar(message: "Twitter Sign in Completed!");
      emit(state.copyWith(isLoading: false, isAuthenticated: true, user: _authService.currentUser)); // emit successfull state
    });
  }

  FutureOr<void> _onAuthEventFacebookSignIn(AuthEventFacebookSignIn event, Emitter<AuthState> emit) async{
    // emit(state.copyWith(isLoading: true));
    final response = await _authService.signInWithFacebook();

    response.fold(
    (l){
      showCustomSnackBar(message: l);
      emit(state.copyWith(isLoading: false,isAuthenticated: false)); // emit unsuccessfull state 
    },(r){
      add(
        AuthEventCreateUser(
          userModel: UserModel(
            id: r.user?.uid ?? '',
            email: r.user!.email ?? '',
            username: r.user?.displayName ?? r.user!.email!.split("@")[0],
            profilePicture: r.user?.photoURL,
            phoneNumber: r.user?.phoneNumber,
          ),
        ),
      );
      showCustomSnackBar(message: "Facebook Sign in Completed!");
      emit(state.copyWith(isLoading: false, isAuthenticated: true, user: _authService.currentUser)); // emit successfull state
    });
  }
}