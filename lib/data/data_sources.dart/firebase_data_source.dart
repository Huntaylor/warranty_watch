import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackGroundMessage(RemoteMessage message) async {
  log('Title: ${message.notification?.title}');
  log('Body: ${message.notification?.body}');
  log('Payload: ${message.data}');
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // final _firebaseAuth = FirebaseAuth.instance;
  // final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> initNotifications() async {
    // final currentUser = _firebaseAuth.currentUser!.uid;
    // final token = await _firebaseFirestore
    //     .doc('users/$currentUser/User Data')
    //     .get()
    //     .then((value) => value.get('messageToken'));
    await _firebaseMessaging.requestPermission();
    // if (token != null){
    final messageToken = await _firebaseMessaging.getToken();
    print(messageToken);
    // }

    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
  }
}
