import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
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
        title: const Text('Demo'),
      ),
      body: const Center(
        child: Text('Demo Page'),
      ),
    );
  }
}
