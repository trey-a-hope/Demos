import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patreon/authenticated_page.dart';
import 'package:patreon/unauthenticated_page.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _requireVerifiedEmail = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final User? firebaseUser = snapshot.data;

        if (firebaseUser == null || _requireVerifiedEmail == true)
          return UnauthenticatedPage();

        String title = '';

        if (firebaseUser.phoneNumber != null)
          title = 'Phone Number';
        else if (firebaseUser.isAnonymous)
          title = 'Anonymous';
        else if (firebaseUser.email != null) title = 'Password';

        return AuthenticatedPage(title: title);
      },
    );
  }
}
