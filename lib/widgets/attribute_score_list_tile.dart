import 'package:flutter/material.dart';

class AttributeScoreListTile extends StatelessWidget {
  const AttributeScoreListTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((value * 100).toStringAsFixed(0) + '%'),
      subtitle: Text(title),
      trailing: value > 0.2
          ? Icon(
              Icons.thumb_down,
              color: Colors.red,
            )
          : Icon(
              Icons.thumb_up,
              color: Colors.green,
            ),
    );
  }
}
