import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as _firebaseauth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user.dart';

abstract class AuthRepository {
  User currentUser();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<void> passwordResetSubmit(String email);
  Future<void> signInWithGoogle();
  Future<void> signinWithApple();
  Future<bool> isFirstRun();
  Future<void> updatePersonalData(
    String firstName,
    String lastName,
    String birthday,
  );
}

class FirebaseAuthRepository implements AuthRepository {
  final _firebaseauth.FirebaseAuth _auth = _firebaseauth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  User currentUser() {
    _firebaseauth.User user = _auth.currentUser!;
    return User(uid: user.uid);
  }

  @override
  Future<bool> isFirstRun() async {
    DocumentSnapshot userdoc = await users.doc(currentUser().uid).get();
    if (userdoc.exists) {
      return false;
    }
    return true;
  }

  //firebase login with email and password
  @override
  Future<User> login(String email, String password) async {
    try {
      _firebaseauth.UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
      return User(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  //logout
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> passwordResetSubmit(String email) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  //firebase login with email and password
  Future<User> register(String email, String password) async {
    try {
      _firebaseauth.UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
      return User(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  //Google Authentication
  Future<User> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final _firebaseauth.OAuthCredential credential =
          _firebaseauth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      _firebaseauth.UserCredential result =
          await _auth.signInWithCredential(credential);
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
      return User(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePersonalData(
      String firstname, String lastName, String birthday) async {
    try {
      await users.doc(currentUser().uid).set(
        {
          'firstName': firstname,
          'lastName': lastName,
          'birthday': birthday,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<User> signinWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential =
          _firebaseauth.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      _firebaseauth.UserCredential result = await _firebaseauth
          .FirebaseAuth.instance
          .signInWithCredential(oauthCredential);
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      return User(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }
}
