import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patreon/demo_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoPage(),
    );
  }
}
