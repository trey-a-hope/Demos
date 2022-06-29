import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//TODO: Extract sign up methods into their own classes.
class UnauthenticatedPage extends StatefulWidget {
  @override
  _UnauthenticatedPageState createState() => _UnauthenticatedPageState();
}

class _UnauthenticatedPageState extends State<UnauthenticatedPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  String? _verificationId;

  @override
  void initState() {
    super.initState();
  }

  void _loginWithPhoneNumber() async {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Unauthenticated'),
      ),
      body: Column(
        children: [
          Text('Email & Password'),
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
              hintStyle:
                  TextStyle(color: Colors.grey, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Colors.white24,
              hintText: 'Email',
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
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
              hintText: 'Password',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  try {
                    _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
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
                child: Text('Create User'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
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
                child: Text('Sign In'),
              ),
            ],
          ),
          Divider(),
          Text('Phone Number'),
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
                      codeSent:
                          (String verificationId, int? resendToken) async {
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
                    _loginWithPhoneNumber();
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
                child: Text('Submit SMS Code'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
