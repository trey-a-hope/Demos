import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final DocumentReference _docRef = FirebaseFirestore.instance
      .collection('cf-data')
      .doc('YAi6rlV6FkYG1fFRqCE7');

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
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _docRef.snapshots(),
          builder: (context, snapshot) {
            // Display circular progress indicator if snapshot is waiting.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Center(
              child: Text(
                'Coins: ${data['coins']}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
