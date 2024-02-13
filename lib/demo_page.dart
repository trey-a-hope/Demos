import 'package:cloud_firestore/cloud_firestore.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini'),
      ),
    );
  }
}
