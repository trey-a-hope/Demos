import 'package:flutter/material.dart';
import 'package:patreon/auth_anonymous.dart';
import 'package:patreon/auth_google.dart';
import 'package:patreon/auth_password.dart';
import 'package:patreon/auth_phone.dart';

class UnauthenticatedPage extends StatefulWidget {
  @override
  _UnauthenticatedPageState createState() => _UnauthenticatedPageState();
}

class _UnauthenticatedPageState extends State<UnauthenticatedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unauthenticated'),
      ),
      body: Center(
        child: Column(
          children: [
            // AuthPassword(),
            AuthPhone(),
            // AuthAnonymous(),
            // AuthGoogle(),
          ],
        ),
      ),
    );
  }
}
