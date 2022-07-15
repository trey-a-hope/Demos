import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthAnonymous extends StatefulWidget {
  @override
  _AuthAnonymousState createState() => _AuthAnonymousState();
}

class _AuthAnonymousState extends State<AuthAnonymous> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _signInAnonymously() async {
    try {
      // Asynchronously creates and becomes an anonymous user.
      // If there is already an anonymous user signed in, that user will be returned instead.
      // If there is any other existing user signed in, that user will be signed out.
      UserCredential userCredential = await _auth.signInAnonymously();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Anonymous',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: ElevatedButton.icon(
            icon: Icon(Icons.login),
            onPressed: () => _signInAnonymously(),
            label: Text('Sign In Anonymously'),
          ),
        ),
      ],
    );
  }
}
