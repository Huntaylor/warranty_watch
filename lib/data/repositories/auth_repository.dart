import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user.dart';

abstract class AuthRepository {
  User currentUser();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<void> passwordResetSubmit(String email);
  Future<void> signInWithGoogle();
  Future<bool> isFirstRun();
  Future<void> updatePersonalData(
    String firstName,
    String lastName,
    String birthday,
  );
}

class FirebaseAuthRepository implements AuthRepository {
  final firebaseauth.FirebaseAuth _auth = firebaseauth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  User currentUser() {
    firebaseauth.User user = _auth.currentUser!;
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
      firebaseauth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      firebaseauth.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
      return User(uid: result.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePersonalData(String firstname, String lastName, String birthday) async {
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
}
