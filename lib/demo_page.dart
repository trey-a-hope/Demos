import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  final fifteenMinsAgo = DateTime.now().subtract(const Duration(minutes: 15));
  final fifteenMinsBefore = DateTime.now().add(const Duration(minutes: 15));

  @override
  void initState() {
    super.initState();
  }

  ListTile _builtTimeagoListTile(DateTime date) => ListTile(
        title: const Text('English'),
        subtitle: Text(
          timeago.format(date, allowFromNow: true),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          _builtTimeagoListTile(fifteenMinsAgo),
          _builtTimeagoListTile(fifteenMinsBefore),
        ],
      ),
    );
  }
}
