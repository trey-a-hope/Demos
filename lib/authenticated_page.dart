import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:patreon/models/user_model.dart';
import 'package:patreon/services/auth_service.dart';
import 'package:patreon/services/user_service.dart';

class AuthenticatedPage extends StatefulWidget {
  AuthenticatedPage({Key? key}) : super(key: key);

  @override
  State<AuthenticatedPage> createState() => _AuthenticatedPageState();
}

class _AuthenticatedPageState extends State<AuthenticatedPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticated Page'),
        actions: [
          IconButton(
            onPressed: () => _authService.signOut(),
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Center(
        child: Text('Authenticated Page'),
      ),
    );
  }

  void _load() async {
    _user = await _authService.getCurrentUser();

    //Request permission from user.
    if (Platform.isIOS) {
      _fcm.requestPermission();
    }

    //Fetch the fcm token for this device.
    String? token = await _fcm.getToken();

    //Validate that it's not null.
    assert(token != null);

    //Update fcm token for this device in firebase.
    _userService.updateUser(
      uid: _user!.uid,
      data: {'fcmToken': token},
    );
  }
}
