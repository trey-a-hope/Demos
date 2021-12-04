import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final TextEditingController _tokenController = TextEditingController();
  String? _token;

  @override
  void initState() {
    super.initState();

    //Request permisson from user.
    if (Platform.isIOS) {
      _fcm.requestPermission();
    }

    //Update user's fcm token.
    _fcm.getToken().then((token) {
      assert(token != null);
      setState(() {
        _token = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Token - $_token',
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              controller: _tokenController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Send Notification'),
                  onPressed: () {
                    print(_tokenController.text);
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.copy),
                  label: Text('Copy Token'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: "your text"));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
