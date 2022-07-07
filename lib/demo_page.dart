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

  bool _requiredVerifiedEmail = true;

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

        if (firebaseUser == null || _requiredVerifiedEmail == true)
          return UnauthenticatedPage();

        return AuthenticatedPage();
      },
    );
  }
}
