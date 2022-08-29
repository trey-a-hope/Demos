import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => Center(
    child: Text('Page $title Content'),
  );
}
