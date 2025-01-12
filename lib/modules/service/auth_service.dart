import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gamers_hub/utils/config/firebase_collections.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
import '../models/user/user_model.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<bool> get isAuthenticated{
    return _firebaseAuth.authStateChanges().map((user) => user != null);
  }

  UserModel? get currentUser{
    if (_firebaseAuth.currentUser == null) return null;
    return UserModel.fromFirebaseUser(_firebaseAuth.currentUser!);
  }

  // Future<DocumentSnapshot<Map<String,dynamic>>> _getUserDocumentSnapshot(String id)async{
  //   return await _firebaseFirestore.collection(FirebaseCollections.usersCollectionPath).doc(id).get();
  // }

  // normal sign in with email and password
  Future<Either<String,UserCredential>> createUserWithEmailAndPassword({required String email,required String password}) async{
    try{
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential);
    }catch(e){
      return const Left('An unexpected error occurred.');
    }
  }
  // normal login with email and password
  Future<Either<String, UserCredential>> signInWithEmailAndPassword({required String email,required String password}) async{
    try{
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential);
    }catch(e){
      return const Left('An unexpected error occurred.');
    }
  }
  Future<Either<String, void>> logout() async{
    try{
      return Right(_firebaseAuth.signOut());
    }on FirebaseAuthException catch (e){
      return Left(e.message ?? 'Something went wrong..');
    }
  }

  Future<Either<String, UserCredential>> googleSignIn() async{
    try{
      // interactive google sign in interface 
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if(googleUser == null){
        return const Left("Cancelled login process");         // if user cancels the google sign in process
      }
      
      // get auth details from the signin
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // create a credential for user
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      return Right(await _firebaseAuth.signInWithCredential(credential));
    }catch(e){
      return Left(e.toString());
    }
  }

  Future<Either<String, UserCredential>> signInWithFacebook() async{
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if(loginResult.status == LoginStatus.success){
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential oAuthCredential = FacebookAuthProvider.credential(accessToken.tokenString);
        return Right(await FirebaseAuth.instance.signInWithCredential(oAuthCredential));
      }else {
        throw FirebaseAuthException(
          code: 'Firebase Login Failed',
          message: 'The facebook login was not successful',
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      return Left('Firebase Auth Exception: ${e.message}');
      // rethrow; // rethrow the exception
    } catch (e) {
      return const Left("Some Error Occured while google Sign in !!");
      // rethrow; // rethrow the exception
    }
  }

  Future<Either<String,UserCredential>> signInWithTwitter() async{
    try{
      final TwitterLogin twitterLogin = TwitterLogin(
        apiKey: dotenv.env['TWITTER_API_KEY']!, 
        apiSecretKey: dotenv.env['TWITTER_API_KEY_SECRET']!, 
        redirectURI: "socialauth://",
      );
      
      final AuthResult authResult = await twitterLogin.loginV2();
      final oAuthCredential = TwitterAuthProvider.credential(accessToken: authResult.authToken!, secret: authResult.authTokenSecret!);

      if(authResult.status == TwitterLoginStatus.loggedIn){
        return Right(await _firebaseAuth.signInWithCredential(oAuthCredential));
      }else if(authResult.status ==  TwitterLoginStatus.cancelledByUser){
        return const Left("Login cancelled !");
      }   // error
      return const Left("Some Error Occured while Twitter Sign in !!");
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      return Left('Firebase Auth Exception: ${e.message}');
      // rethrow; // rethrow the exception
    } catch(e){
      return const Left("Some Error Occured while Twitter Sign in !!");
    }
  }

  Future<Either<String, void>> createUser({required UserModel userModel})async{
    try{
      final ref = _firebaseFirestore.collection(FirebaseCollections.usersCollectionPath).doc(userModel.id);
      return Right(await ref.set(userModel.toMap()));
    }catch(e){
      return Left('Error - ${e.toString()}');
    }
  }

  Future<Either<String, void>> updateUserInfo({required Map<String,dynamic> updatedFields,required String id}) async{
    try{
      final ref = _firebaseFirestore.collection(FirebaseCollections.usersCollectionPath).doc(id);
      return Right(await ref.update(updatedFields));
    }catch(e){
      return Left('Error - ${e.toString()}');
    }
  }
}