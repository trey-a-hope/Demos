import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patreon/fcm_notification_service.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final CollectionReference _tokensDB =
      FirebaseFirestore.instance.collection('Tokens');
  final FCMNotificationService _fcmNotificationService =
      FCMNotificationService();

  @override
  void initState() {
    super.initState();

    //Subscribe to the NEWS topic.
    _fcmNotificationService.subscribeToTopic(topic: 'NEWS');

    load();
  }

  Future<void> load() async {
    //Request permission from user.
    if (Platform.isIOS) {
      _fcm.requestPermission();
    }

    //Fetch the fcm token for this device.
    String? token = await _fcm.getToken();

    //Validate that it's not null.
    assert(token != null);

    //Update fcm token for this device in firebase.
    DocumentReference docRef = _tokensDB.doc('iOS FCM Token');
    docRef.set({'token': token});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: fcm configure in app notifications.
          ],
        ),
      ),
    );
  }
}
