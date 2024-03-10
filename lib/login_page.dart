import 'package:demos/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() => _loading = true);
              final auth = FirebaseAuth.instance;
              // Sign the user in anonymously.
              await auth.signInAnonymously();
              setState(() => _loading = false);
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FlutterLogin(
              logo: const AssetImage(Globals.keyChainLogo),
              title: 'Alicia\'s Keyz',
              theme: LoginTheme(
                accentColor: Colors.white,
              ),
              onSignup: (signupData) async {
                return null;
              },
              onRecoverPassword: (email) {
                return null;
              },
              onLogin: (loginData) {
                return null;
              },
            ),
    );
  }
}
