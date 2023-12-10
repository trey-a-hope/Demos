import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('${widget.title} Page'),
      ),
    );
  }
}
