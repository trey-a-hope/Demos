import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demos/extensions/_extensions.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final pushNotificationsDataColRef =
      FirebaseFirestore.instance.collection('push_notifications_data');

  @override
  void initState() {
    super.initState();

    testIt();
  }

  void testIt() {
    final int? int1 = 1;
    final int int2 = 1;
    final result = int1 + int2;

    bool online = false;
    bool selfish = true;

    bool total = online * selfish;
    debugPrint('$total');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Demo Page'),
        ),
      ),
    );
  }
}
