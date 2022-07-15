import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPassword extends StatefulWidget {
  @override
  _AuthPasswordState createState() => _AuthPasswordState();
}

class _AuthPasswordState extends State<AuthPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Password',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
                  // Tries to create a new user account with the given email address and password.
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
                  // Attempts to sign in a user with the given email address and password.
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
      ],
    );
  }
}
