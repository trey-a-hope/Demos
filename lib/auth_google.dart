import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle extends StatefulWidget {
  @override
  _AuthGoogleState createState() => _AuthGoogleState();
}

class _AuthGoogleState extends State<AuthGoogle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    // Trigger the authentication flow.
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request.
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential.
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Asynchronously signs in to Firebase with the given 3rd-party credentials
    // (e.g. a Facebook login Access Token, a Google ID Token/Access Token pair, etc.) and returns additional identity provider data.
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Google',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: ElevatedButton.icon(
            icon: Icon(Icons.login),
            onPressed: () => _signInWithGoogle(),
            label: Text('Google Sign In'),
          ),
        ),
      ],
    );
  }
}
