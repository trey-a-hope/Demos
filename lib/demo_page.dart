import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

extension BooleanMultiplication on bool {
  bool operator *(bool other) {
    final shadow = this;

    if ((shadow && other) || (!shadow && !other)) {
      return true;
    } else {
      return false;
    }
  }
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
