import 'package:demos/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatarWidget(
                src: user.photoURL ?? Globals.dummyProfileImageUrl),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                user.displayName ?? 'No Display Name',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'UID: ${user.uid}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (user.isAnonymous) ...[
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  'Anonymous User',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
            ElevatedButton(
              onPressed: () => _auth.signOut(),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  final String src;

  const CircleAvatarWidget({
    super.key,
    required this.src,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80.0,
      backgroundColor: Colors.blue,
      child: ClipOval(
        child: Image.network(
          src,
          width: 160.0,
          height: 160.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
