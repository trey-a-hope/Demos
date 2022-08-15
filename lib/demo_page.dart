import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final List<String> _labels = ['Apple', 'Banana', 'Orange', 'Kiwi'];

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
          /* Top 20 Properties */

          /// Divider color.
          dividerColor: Colors.purple,

          /// Active background color.
          activeBgColor: [Colors.green],

          /// Active foreground color.
          activeFgColor: Colors.black,

          /// Inactive background color.
          inactiveBgColor: Colors.cyan,

          /// Inactive foreground color.
          inactiveFgColor: Colors.black,

          /// List of labels.
          labels: _labels,

          /// Total number of switches.
          totalSwitches: _labels.length,

          /// List of icons.
          // icons: _labels.map((label) => Icons.computer).toList(),

          /// List of active foreground colors.
          activeBgColors: _labels
              .map((label) => [
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0)
                  ])
              .toList(),

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

          /// OnToggle function.
          onToggle: (index) {
            debugPrint('$index');
          },

          /// Change selection on tap.
          changeOnTap: true,

          /// Confirm if text direction is set right-to-left.
          textDirectionRTL: false,

          /// Initial label index, set to null for no chosen initial value (all options inactive).
          initialLabelIndex: 0,

          /// Tap active switch to de-activate/de-select.
          doubleTapDisable: true,

          /// Use toggle switch vertically.
          isVertical: true,

          /* Other 10 */

          /// Border color.
          borderColor: null,

          /// Border width.
          borderWidth: null,

          /// List of custom text styles.
          customTextStyles: null,

          /// List of custom icons.
          customIcons: null,

          /// List of custom widths.
          customWidths: null,

          /// List of custom heights.
          customHeights: null,

          /// Set a border only to the active toggle component.
          activeBorders: null,

          /// Set radius style.
          radiusStyle: false,

          /// Animation curve.
          curve: Curves.easeIn,

          /// Set animation.
          animate: true,

          /// Set animation duration.
          animationDuration: 1,

          /// Divider margin.
          dividerMargin: 8.0,
        ),
      ),
    );
  }
}
