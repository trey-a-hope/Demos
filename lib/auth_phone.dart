import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPhone extends StatefulWidget {
  @override
  _AuthPhoneState createState() => _AuthPhoneState();
}

class _AuthPhoneState extends State<AuthPhone> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  String? _verificationId;

  @override
  void initState() {
    super.initState();
  }

  void _verify() async {
    if (_verificationId == null) return;

    try {
      String smsCode = _smsCodeController.text;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
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
            'Phone Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _phoneNumberController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(90.0),
              ),
              borderSide: BorderSide.none,
            ),
            hintStyle:
                TextStyle(color: Colors.grey, fontFamily: "WorkSansLight"),
            filled: true,
            fillColor: Colors.white24,
            hintText: 'Phone Number',
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _smsCodeController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.code,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(90.0),
              ),
              borderSide: BorderSide.none,
            ),
            hintStyle:
                TextStyle(color: Colors.grey, fontFamily: "WorkSansLight"),
            filled: true,
            fillColor: Colors.white24,
            hintText: 'SMS Code',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.verifyPhoneNumber(
                    phoneNumber: '+1${_phoneNumberController.text}',
                    verificationCompleted: (PhoneAuthCredential credential) {
                      print('verificationCompleted');
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      print('verificationFailed');
                    },
                    codeSent: (String verificationId, int? resendToken) async {
                      setState(() {
                        _verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      print('codeAutoRetrievalTimeout');
                    },
                  );
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message!),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('An unknown error occured.'),
                      ),
                    );
                  }
                }
              },
              child: Text('Send Verification Code'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  _verify();
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message!),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('An unknown error occured.'),
                      ),
                    );
                  }
                }
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ],
    );
  }
}
