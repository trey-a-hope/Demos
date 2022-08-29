import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';

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
        // The first pane.
        startPane: Column(
          children: [
            Text('Pane A'),
            if (_showBothPanes) ...[
              Slider(
                value: _paneProportion,
                min: _minPaneProportion,
                max: _maxPaneProportion,
                onChanged: (double value) {
                  setState(
                    () => _paneProportion = value,
                  );
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
        // The second pane.
        endPane: Column(
          children: [
            Text('Pane B'),
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
        // Proportion of the available space occupied by the first pane.
        paneProportion: _paneProportion,
        // Whether to show only one pane and which one, or both.
        panePriority:
            _showBothPanes ? TwoPanePriority.both : TwoPanePriority.start,
        // Direction of the panes.
        direction: _directionIsHorizontal ? Axis.horizontal : Axis.vertical,

        // Order of the panes when in vertical direction.
        verticalDirection: _verticalDirectionIsUp
            ? VerticalDirection.up
            : VerticalDirection.down,
      ),
    );
  }
}