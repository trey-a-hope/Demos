import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatedPage extends StatefulWidget {
  AuthenticatedPage({
    required this.title,
    required this.uid,
  });

  // How was the app authenticated.
  final String title;

  // UID of the authenticated user.
  final String uid;

  @override
  _AuthenticatedPageState createState() => _AuthenticatedPageState();
}

class _AuthenticatedPageState extends State<AuthenticatedPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticated by ${widget.title}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back user ${widget.uid}',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.signOut();
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
