import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Cloud Firestore table that holds the translation info.
  final DocumentReference _translationDocRef = FirebaseFirestore.instance
      .collection('translations')
      .doc('ufWEv06nWjSuZZw2lQYB');

  /// Controller for updating translation input text.
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate Text'),
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _translationDocRef.snapshots(),
          builder: (context, snapshot) {
            // Display circular progress indicator if snapshot is waiting.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Convert the snapshot to a map.
            Map translation = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                ListTile(
                  title: Text(translation['input']),
                  subtitle: Text('English'),
                ),
                Divider(),
                ListTile(
                  title: Text(translation['translated']['de']),
                  subtitle: Text('German'),
                ),
                ListTile(
                  title: Text(translation['translated']['es']),
                  subtitle: Text('Spanish'),
                ),
                ListTile(
                  title: Text(translation['translated']['fr']),
                  subtitle: Text('French'),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Input',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.blue),
                        onPressed: () async {
                          // Update the input field on the translation document.
                          await _translationDocRef.update(
                            {'input': _textController.text},
                          );

                          // Clear the text field to prepare for next input.
                          _textController.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
