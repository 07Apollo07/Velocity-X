import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/scannerController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/wrapper.dart';
import 'package:velocityx/services/usersDb.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser;

  User? get user => _firebaseUser.value;

  @override
  onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    ever(_firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.delete<UserController>(force: true);
      Get.delete<FilesController>(force: true);
      Get.delete<ScannerV2Controller>(force: true);
      Get.offAll(() => SignIn());
    } else {
      Get.offAll(() => Wrapper());

      Get.put(UserController());
      Get.put(FilesController());
    }
  }

  void signInWithGoogle() async {
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
          UserCredential _authResult =
              await _auth.signInWithPopup(googleProvider);

          UserModel _user = UserModel(
            id: _authResult.user?.uid,
            f_name: _authResult.additionalUserInfo?.profile!['given_name'],
            l_name: _authResult.additionalUserInfo?.profile!['family_name'],
            email: _authResult.user?.email,
          );

          if (await UserDb().createNewUser(_user)) {
            Get.find<UserController>().user = _user;
            Get.back();
          }
          // Get.snackbar("Signed In", "Signed In using Google");
        } catch (e) {
          print(e.toString());
          Get.snackbar(
            "Error creating Account",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
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
            UserCredential _authResult =
                await FirebaseAuth.instance.signInWithCredential(credential);
            print("Google Android Sign In Auth Result");
            print(await _authResult);
            UserModel _user = UserModel(
              id: _authResult.user?.uid,
              f_name: _authResult.additionalUserInfo?.profile!['given_name'],
              l_name: _authResult.additionalUserInfo?.profile!['family_name'],
              email: _authResult.user?.email,
            );
            if (await UserDb().createNewUser(_user)) {
              Get.find<UserController>().user = _user;
              Get.snackbar("Signed In", "Signed In using Google");
              Get.back();
            }
          } catch (e) {
            print(e.toString());
            Get.snackbar(
              "Error creating Account",
              e.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void createUser(
      String f_name, String l_name, String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart
      UserModel _user = UserModel(
        id: _authResult.user?.uid,
        f_name: f_name.trim(),
        l_name: l_name.trim(),
        email: _authResult.user?.email,
        joining_date: Timestamp.now(),
      );
      if (await UserDb().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await UserDb().getUser(_authResult.user!.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // sign out
  Future signOut() async {
    try {
      print("Signing Out");
      print(_firebaseUser);
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
