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

  bool _showSMSCodeTextBox = false;

  // ID of the verification method, used for creating phone credential.
  String? _verificationId;

  @override
  void initState() {
    super.initState();
  }

  void _verify() async {
    if (_verificationId == null) return;

    try {
      String smsCode = _smsCodeController.text;

      // Create a new [PhoneAuthCredential] from a provided [verificationId] and [smsCode].
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
        if (_showSMSCodeTextBox) ...[
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
            onChanged: (val) => setState(() {}),
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  // Starts a phone number verification process for the given phone number.
                  // This method is used to verify that the user-provided phone number belongs to the user.
                  // Firebase sends a code via SMS message to the phone number, where you must then prompt the user
                  // to enter the code. The code can be combined with the verification ID to create a
                  // [PhoneAuthProvider.credential] which you can then use to sign the user in, or link with their
                  // account ( see [signInWithCredential] or [linkWithCredential]).
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

                  //Show the SMS Code text box.
                  setState(() {
                    _showSMSCodeTextBox = true;
                  });
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
            if (_smsCodeController.text.length == 6) ...[
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
              )
            ]
          ],
        ),
      ],
    );
  }
}
