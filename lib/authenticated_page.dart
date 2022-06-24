import 'package:flutter/material.dart';

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
          onPressed: () => {},
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
