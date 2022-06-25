import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patreon/authenticated_page.dart';
import 'package:patreon/unauthenticated_page.dart';

import 'services/auth_service.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().onAuthStateChanged(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final User? firebaseUser = snapshot.data;

        if (firebaseUser == null) return UnauthenticatedPage();

        return AuthenticatedPage();
      },
    );
  }
}
