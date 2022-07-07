import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthEmailLink extends StatefulWidget {
  @override
  _AuthEmailLinkState createState() => _AuthEmailLinkState();
}

class _AuthEmailLinkState extends State<AuthEmailLink> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  bool _isEmailVerified = false;
  bool _canResendEmail = true;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _isEmailVerified =
        _auth.currentUser == null ? false : _auth.currentUser!.emailVerified;

    if (!_isEmailVerified) {
      _sendVerificationEmail();

      _timer =
          Timer.periodic(Duration(seconds: 3), (timer) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  checkEmailVerified() {}

  Future<void> _sendVerificationEmail() async {
    try {
      final User user = _auth.currentUser!;
      await user.sendEmailVerification();

      setState(() => _canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => _canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Email Link',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _isEmailVerified
            ? Column(
                children: [
                  Text(
                    'A verification email has been sent to this email.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.email),
                        onPressed: () =>
                            _canResendEmail ? _sendVerificationEmail() : null,
                        label: Text('Resent Email'),
                      ),
                    ],
                  )
                ],
              )
            : Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(90.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontFamily: "WorkSansLight"),
                      filled: true,
                      fillColor: Colors.white24,
                      hintText: 'Email',
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await _auth.sendSignInLinkToEmail(
                            email: _emailController.text,
                            actionCodeSettings: ActionCodeSettings(
                              // URL you want to redirect back to. The domain (www.example.com) for this
                              // URL must be whitelisted in the Firebase Console.
                              url: 'https://demos-6737f.web.app',

                              // This must be true
                              handleCodeInApp: true,
                              iOSBundleId: 'com.example.demos',
                              androidPackageName: 'com.example.demos',
                              // installIfNotAvailable
                              androidInstallApp: true,
                              // minimumVersion
                              androidMinimumVersion: '12',
                            ),
                          );
                          // Display success modal.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Account created.'),
                            ),
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: Text('Send Email'),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
