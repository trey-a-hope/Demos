import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: ToggleSwitch(
          /// Initial label index, set to null for no chosen initial value (all options inactive).
          initialLabelIndex: 0,

          /// Total number of switches
          totalSwitches: 3,

          /// List of labels
          labels: ['America', 'Canada', 'Mexico'],

          /// OnToggle function
          onToggle: (index) {
            print('switched to: $index');
          },
        ),
      ),
    );
  }
}
