import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';

import 'page_widget.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Proportion of the available space occupied by the first pane.
  double _paneProportion = 0.3;

  /// Horizontal or vertical alignment of panes.
  bool _directionIsHorizontal = true;

  /// Up or down direction for vertical alignment.
  bool _verticalDirectionIsUp = true;

  /// Show both panes or not.
  bool _showBothPanes = true;

  /// The minimum pane proportion.
  static const double _minPaneProportion = 0.3;

  /// The maximum pane proportion.
  static const double _maxPaneProportion = 0.65;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foldable & Dual Screen Devices Demo'),
      ),
      body: TwoPane(
        startPane: Column(
          children: [
            PageWidget(title: 'A'),
            if (_showBothPanes) ...[
              Slider(
                value: _paneProportion,
                min: _minPaneProportion,
                max: _maxPaneProportion,
                onChanged: (double value) {
                  // if (value > 30 && value < 70) {
                  setState(
                    () => _paneProportion = value,
                  );
                  // }
                },
              ),
              Text((_paneProportion * 100).round().toString() + '%'),
            ],
            SwitchListTile(
              title: const Text('Show Both Panes'),
              value: _showBothPanes,
              onChanged: (bool value) {
                setState(() => _showBothPanes = value);
              },
            ),
          ],
        ),
        endPane: Column(
          children: [
            PageWidget(title: 'B'),
            SwitchListTile(
              title: Text(
                  'Direction is ${_directionIsHorizontal ? 'Horizontal' : 'Vertical'}'),
              value: _directionIsHorizontal,
              onChanged: (bool value) {
                setState(() => _directionIsHorizontal = value);
              },
            ),
            if (!_directionIsHorizontal) ...[
              SwitchListTile(
                title: Text(
                    'Vertical Direction is ${_verticalDirectionIsUp ? 'Up' : 'Down'}'),
                value: _verticalDirectionIsUp,
                onChanged: (bool value) {
                  setState(() => _verticalDirectionIsUp = value);
                },
              ),
            ]
          ],
        ),
        paneProportion: _paneProportion,
        panePriority:
            _showBothPanes ? TwoPanePriority.both : TwoPanePriority.start,
        direction: _directionIsHorizontal ? Axis.horizontal : Axis.vertical,
        verticalDirection: _verticalDirectionIsUp
            ? VerticalDirection.up
            : VerticalDirection.down,
      ),
    );
  }
}

//TODO: Add all sliders and switches to be outside of TwoPane widget, (that way the widgets are jumping everywhere).
