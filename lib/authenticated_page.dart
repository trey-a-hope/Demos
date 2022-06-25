import 'package:flutter/material.dart';
import 'package:patreon/services/auth_service.dart';

class AuthenticatedPage extends StatefulWidget {
  @override
  _AuthenticatedPageState createState() => _AuthenticatedPageState();
}

class _AuthenticatedPageState extends State<AuthenticatedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticated by Email/Password'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await AuthService().signOut();
            } catch (e) {
              print(e.toString());
            }
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
