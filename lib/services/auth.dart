import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocityx/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // GoogleSignIn _gooogleSignIn = GoogleSignIn();

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        try {
          // Create a new provider
          GoogleAuthProvider googleProvider = GoogleAuthProvider();

          googleProvider
              .addScope('https://www.googleapis.com/auth/contacts.readonly');
          googleProvider
              .setCustomParameters({'login_hint': 'user@example.com'});

          // Once signed in, return the UserCredential
          return await FirebaseAuth.instance.signInWithPopup(googleProvider);
          
          // Or use signInWithRedirect
          // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
        } catch (e) {
          print(e.toString());
        }
      } else {
        if (Platform.isAndroid) {
          try {
            // Trigger the authentication flow
            final GoogleSignInAccount? googleUser =
                await GoogleSignIn().signIn();

            // Obtain the auth details from the request
            final GoogleSignInAuthentication? googleAuth =
                await googleUser?.authentication;

            // Create a new credential
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );

            // Once signed in, return the UserCredential
            return await FirebaseAuth.instance.signInWithCredential(credential);
          } catch (e) {
            print(e.toString());
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    throw "";
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
