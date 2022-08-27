import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patreon/models/user_model.dart';
import 'package:patreon/services/user_service.dart';

class UnauthenticatedPage extends StatefulWidget {
  UnauthenticatedPage({Key? key}) : super(key: key);

  @override
  State<UnauthenticatedPage> createState() => _UnauthenticatedPageState();
}

class _UnauthenticatedPageState extends State<UnauthenticatedPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserService _userService = UserService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unauthenticated Page'),
      ),
      body: SafeArea(
        child: Column(
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
                  onPressed: () async {
                    try {
                      // Tries to create a new user account with the given email address and password.
                      UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      // Create the user in firebase.
                      _userService.createUser(
                        user: UserModel(
                          uid: userCredential.user!.uid,
                          email: userCredential.user!.email!,
                          created: DateTime.now(),
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
        ),
      ),
    );
  }
}
