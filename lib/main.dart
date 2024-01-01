import 'package:demos/demo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// https://github.com/vandadnp/youtube-riverpodcourse-public/tree/main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoPage(),
    );
  }
}
