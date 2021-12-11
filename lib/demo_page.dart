import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final CollectionReference _tokensDB =
      FirebaseFirestore.instance.collection('Tokens');

  @override
  void initState() {
    super.initState();

    //Subscribe to the NEWS topic.
    _fcm.subscribeToTopic('NEWS');

    //Add listener for incoming messages.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        String title = message.notification!.title!;
        String body = message.notification!.body!;
        _showMessage(title: title, body: body);
      } else {
        _showMessage(title: 'Error', body: 'No notification body.');
      }
    });

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

  void _showMessage({required String title, required String body}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications Demo'),
      ),
      body: Container(),
    );
  }
}
