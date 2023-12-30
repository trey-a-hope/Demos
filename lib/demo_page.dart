import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_wrapper/exception/flutter_fcm_wrapper_invalid_data_exception.dart';
import 'package:flutter_fcm_wrapper/exception/flutter_fcm_wrapper_respond_exception.dart';
import 'package:flutter_fcm_wrapper/flutter_fcm_wrapper.dart';

const apiKey =
    'AAAAKtv8aAU:APA91bG8xo7bA0EZuHbjnUo6swtLe9MVBFqWGZTmHorydZYaX9nC6YVj6dyADiwnDdxe5vuo-P6_EbHcdixZ4JmZX8SKCAWfjEE70fK-Eou1qMjqDD8MRpioqQTxcHxTN3LVTyk7F7G0';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _fcm = FirebaseMessaging.instance;

  final pushNotificationsDataColRef =
      FirebaseFirestore.instance.collection('push_notifications_data');

  String? _token;

  FlutterFCMWrapper flutterFCMWrapper = const FlutterFCMWrapper(
    apiKey: apiKey,
    enableLog: true,
    enableServerRespondLog: true,
  );

  @override
  void initState() {
    super.initState();

    //Add listener for incoming messages.
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (message.notification != null) {
          String title = message.notification!.title!;
          String body = message.notification!.body!;
          _showMessage(title: title, body: body);
        } else {
          _showMessage(title: 'Error', body: 'No notification body.');
        }
      },
    );

    load();
  }

  Future<void> load() async {
    //Request permission from user.
    if (Platform.isIOS) {
      await _fcm.requestPermission();
    }

    //Fetch the fcm token for this device.
    String? token = await _fcm.getToken();

    // Update the global token value.
    _token = token;

    // Update the token in the database.
    await pushNotificationsDataColRef.doc('EH6ZOGuI2gUM1oUKJ3a5').update({
      'token': token,
    });
  }

  void _sendMessage({
    required String title,
    required String body,
  }) async {
    try {
      if (_token == null) {
        _showMessage(title: 'Error', body: 'No token.');
        return;
      }

      Map<String, dynamic> result =
          await flutterFCMWrapper.sendMessageByTokenID(
        userRegistrationTokens: [_token!],
        title: title,
        body: body,
        androidChannelID: "example",
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      );

      debugPrint('$result');
    } on FlutterFCMWrapperInvalidDataException catch (e) {
      debugPrint(e.toString());
    } on FlutterFCMWrapperRespondException catch (e) {
      debugPrint(e.toString());
    }
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
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications Demo'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _sendMessage(title: 'Welcome!', body: 'Are you ok?');
              },
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
