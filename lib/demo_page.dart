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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            Map translation = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                TranslationListTile(
                    country: 'English', text: translation['input']),
                TranslationListTile(
                    country: 'German', text: translation['translated']['de']),
                TranslationListTile(
                    country: 'Spanish', text: translation['translated']['es']),
                TranslationListTile(
                    country: 'French', text: translation['translated']['fr']),
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
                          await _translationDocRef.update(
                            {'input': _textController.text},
                          );

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

class TranslationListTile extends StatelessWidget {
  const TranslationListTile({
    Key? key,
    required this.country,
    required this.text,
  }) : super(key: key);

  final String country;
  final String text;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text('"$text"'),
        subtitle: Text(country),
      );
}
