import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// The collection referrence for the comments.
  static final CollectionReference _commentsColRef =
      FirebaseFirestore.instance.collection('comments');

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
        title: Text('Analyze Toxicity'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              _commentsColRef.orderBy('created', descending: true).snapshots(),
          builder: (context, snapshot) {
            // Display circular progress indicator if snapshot is waiting.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Convert snapshot data into list of map objects.
            List<Map> comments = snapshot.data!.docs.map((doc) {
              Map comment = doc.data() as Map<String, dynamic>;

              return comment;
            }).toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (_, index) {
                      // Convert created value to timestamp object.
                      Timestamp timestamp =
                          comments[index]['created'] as Timestamp;

                      // Convert timestamp to datetime.
                      DateTime created = DateTime.fromMicrosecondsSinceEpoch(
                          timestamp.microsecondsSinceEpoch);

                      return ListTile(
                        title: Text(comments[index]['input']),
                        subtitle:
                            Text('Posted @ ${DateFormat.jm().format(created)}'),
                        trailing: Icon(
                          Icons.thumb_down,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 5,
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Leave comment here...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.blue),
                        onPressed: () async {
                          // Create new comment.
                          DocumentReference _documentReference =
                              _commentsColRef.doc();

                          _documentReference.set(
                            {
                              'input': _textController.text,
                              'created': DateTime.now(),
                            },
                          );

                          // Clear the text field.
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
