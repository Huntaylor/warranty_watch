import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/models/user.dart';
import 'package:warranty_watch/app/data/models/user_data.dart';

abstract class AuthRepository {
  WarrantyUser currentUser();
  Future<void> login(String email, String password);
  Future<void> register(
    String email,
    String password,
    UserData userData,
  );
  Future<void> logout();
  Future<void> passwordResetSubmit(String email);
  Future<void> signInWithGoogle();
  Future<void> signinWithApple();
  Future<bool> isFirstRun();
  Future<void> updatePersonalData(UserData userData);
}

class FirebaseAuthRepository implements AuthRepository {
  final firebaseauth.FirebaseAuth _auth = firebaseauth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  WarrantyUser currentUser() {
    firebaseauth.User user;
    if (_auth.currentUser != null) {
      user = _auth.currentUser!;
    } else {
      return WarrantyUser();
    }
    return WarrantyUser(uid: user.uid);
  }

  @override
  Future<bool> isFirstRun() async {
    final userdoc = await users.doc(currentUser().uid).get();
    if (userdoc.exists) {
      return false;
    }
    return true;
  }

  //firebase login with email and password
  @override
  Future<WarrantyUser> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      const key = 'uid';
      final val = result.user!.uid;
      await prefs.setString(key, val);

      await _auth.currentUser!.getIdToken(true);
      return WarrantyUser(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  //logout
  Future<void> logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> passwordResetSubmit(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  @override
  //firebase login with email and password
  Future<WarrantyUser> register(
    String email,
    String password,
    UserData userData,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      const key = 'uid';
      final val = result.user!.uid;
      await prefs.setString(key, val);

      FirebaseFirestore.instance
          .collection('users/${currentUser().uid}/warranties');

      await users.doc(currentUser().uid).set(
            userData.toJson(),
          );

      return WarrantyUser(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  //Google Authentication
  Future<WarrantyUser> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser!.authentication;

      // Create a new credential
      final credential = firebaseauth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final result = await _auth.signInWithCredential(credential);
      final prefs = await SharedPreferences.getInstance();
      const key = 'uid';
      final val = result.user!.uid;
      await prefs.setString(key, val);
      return WarrantyUser(uid: result.user!.uid);
    } catch (e) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<void> updatePersonalData(UserData userData) async {
    try {
      await users.doc(currentUser().uid).update(
        {
          ...userData.toJson(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signinWithApple() {
    // TODO(huntaylor): implement signinWithApple
    throw UnimplementedError();
  }
}
