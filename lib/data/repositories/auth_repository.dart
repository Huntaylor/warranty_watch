import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user.dart';

abstract class AuthRepository {
  WarrantyUser currentUser();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<void> passwordResetSubmit(String email);
  Future<void> signInWithGoogle();
  Future<void> signinWithApple();
  Future<bool> isFirstRun();
  Future<bool> isEmailAlreadyInUse(String email);
  Future<void> updatePersonalData(
    String firstName,
    String lastName,
  );
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
    DocumentSnapshot userdoc = await users.doc(currentUser().uid).get();
    if (userdoc.exists) {
      return false;
    }
    return true;
  }

  //firebase login with email and password
  @override
  Future<WarrantyUser> login(String email, String password) async {
    try {
      firebaseauth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
      return WarrantyUser(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      return false; // Return false if an error occurs
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
  Future<WarrantyUser> register(String email, String password) async {
    try {
      firebaseauth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Create a new credential
      final firebaseauth.OAuthCredential credential = firebaseauth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      firebaseauth.UserCredential result = await _auth.signInWithCredential(credential);
      final prefs = await SharedPreferences.getInstance();
      var key = 'uid';
      var val = result.user!.uid;
      prefs.setString(key, val);
      return WarrantyUser(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePersonalData(String firstname, String lastName) async {
    try {
      await users.doc(currentUser().uid).collection('User Data').doc().set(
        {
          'firstName': firstname,
          'lastName': lastName,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signinWithApple() {
    // TODO: implement signinWithApple
    throw UnimplementedError();
  }
}
