import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final List<String> _labels = ['Apple', 'Banana', 'Orange'];

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
          /// Border color.
          borderColor: null,

          /// Divider color.
          dividerColor: Colors.black,

          /// Active background color.
          activeBgColor: null,

          /// Active foreground color.
          activeFgColor: null,

          /// Inactive background color
          inactiveBgColor: null,

          /// Inactive foreground color.
          inactiveFgColor: Colors.black,

          /// List of labels.
          labels: _labels,

          /// Total number of switches.
          totalSwitches: _labels.length,

          /// List of icons.
          icons: null,

          /// List of active foreground colors.
          activeBgColors: _labels
              .map((label) => [
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0)
                  ])
              .toList(),

          /// List of custom text styles.
          customTextStyles: null,

          /// List of custom icons.
          customIcons: null,

          /// List of custom widths.
          customWidths: null,

          /// List of custom heights.
          customHeights: null,

          /// Minimum switch width.
          minWidth: 100,

          /// Minimum switch height.
          minHeight: 100,

          /// Widget's corner radius.
          cornerRadius: 20,

          /// Font size.
          fontSize: 21,

          /// Icon size.
          iconSize: 21,

          /// Divider margin.
          dividerMargin: 8,

          /// Border width.
          borderWidth: null,

          /// OnToggle function.
          onToggle: (index) {
            print('switched to: $index');
          },

          /// Change selection on tap.
          changeOnTap: true,

          /// Set animation.
          animate: true,

          /// Set animation duration.
          animationDuration: 1,

          /// Set radius style.
          radiusStyle: false,

          /// Confirm if text direction is set right-to-left.
          textDirectionRTL: false,

          /// Animation curve
          curve: Curves.easeIn,

          /// Initial label index, set to null for no chosen initial value (all options inactive).
          initialLabelIndex: 0,

          /// Tap active switch to de-activate/de-select.
          doubleTapDisable: false,

          /// Use toggle switch vertically.
          isVertical: false,

          /// Set a border only to the active toggle component.
          activeBorders: null,
        ),
      ),
    );
  }
}
