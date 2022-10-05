import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final DocumentReference _docRef = FirebaseFirestore.instance
      .collection('comments')
      .doc('4whLwksJlXOoWoWRb1k0');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_docRef.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Text('Demo Page'),
      ),
    );
  }
}
