import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patreon/attribute_score_listtile.dart';
import 'package:patreon/comment_model.dart';

import 'comment_score_listtile.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// The collection referrence for the comments.
  final DocumentReference _commentDocRef = FirebaseFirestore.instance
      .collection('comments')
      .doc('faZzfqHiYG4ya4g9Pz3A');

  /// Controller for updating translation input text.
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /// Returns the average score between all attributes.
  double _getCommentAverageAttributeScore({required CommentModel comment}) {
    return (comment.identityAttack! +
            comment.insult! +
            comment.profanity! +
            comment.severeToxicity! +
            comment.threat! +
            comment.toxicity!) /
        6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyze Toxicity'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _commentDocRef.snapshots(),
          builder: (context, snapshot) {
            // Display circular progress indicator if snapshot is waiting.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Convert snapshot data into comment object.
            CommentModel comment = CommentModel.fromJson(
                snapshot.data!.data() as Map<String, dynamic>);

            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CommentScoreListTile(
                        title: '"${comment.text}"',
                        value:
                            _getCommentAverageAttributeScore(comment: comment),
                      ),
                      Divider(),
                      if (comment.identityAttack != null) ...[
                        AttributeScoreListTile(
                          title: 'Identity Attack',
                          value: comment.identityAttack!,
                        )
                      ],
                      if (comment.insult != null) ...[
                        AttributeScoreListTile(
                          title: 'Insult',
                          value: comment.insult!,
                        )
                      ],
                      if (comment.profanity != null) ...[
                        AttributeScoreListTile(
                          title: 'Profanity',
                          value: comment.profanity!,
                        )
                      ],
                      if (comment.severeToxicity != null) ...[
                        AttributeScoreListTile(
                          title: 'Severe Toxicity',
                          value: comment.severeToxicity!,
                        )
                      ],
                      if (comment.threat != null) ...[
                        AttributeScoreListTile(
                          title: 'Threat',
                          value: comment.threat!,
                        )
                      ],
                      if (comment.toxicity != null) ...[
                        AttributeScoreListTile(
                          title: 'Toxicity',
                          value: comment.toxicity!,
                        )
                      ],
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 3,
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Leave comment here...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.blue),
                        onPressed: () async {
                          // Update the text on the comment.
                          _commentDocRef.update(
                            {
                              'text': _textController.text,
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
