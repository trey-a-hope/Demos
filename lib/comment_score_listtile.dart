import 'package:flutter/material.dart';

class CommentScoreListTile extends StatelessWidget {
  const CommentScoreListTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: value > 0.2
          ? Text(
              'Sorry, this comment is potentially harmful.',
              style: TextStyle(color: Colors.red),
            )
          : Text(
              'This comment is good.',
              style: TextStyle(color: Colors.green),
            ),
      trailing: value > 0.2
          ? Icon(
              Icons.cancel,
              color: Colors.red,
            )
          : Icon(
              Icons.check,
              color: Colors.green,
            ),
    );
  }
}
