import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  late SignatureController _controller;

  static const _strokeStartIndex = -1;
  final List<List<List<Point>>> _savedDrawings = [];
  List<List<Point>> _strokeHistory = [];
  int _currentStrokeIndex = _strokeStartIndex;
  List<Point> _currentPoints = [];

  bool get canUndo => _currentStrokeIndex > _strokeStartIndex;
  bool get canRedo => _currentStrokeIndex < _strokeHistory.length - 1;

  @override
  void initState() {
    super.initState();

    _controller = SignatureController(
      penColor: Colors.black,
      penStrokeWidth: 5,
      onDrawStart: () => setState(
        () {},
      ),
      onDrawEnd: () => setState(
        () {
          _currentStrokeIndex++;

          final stroke = _controller.points
              .where((p) => !_currentPoints.contains(p))
              .toList();

          _currentPoints = List<Point>.from(_controller.points);

          _strokeHistory = _strokeHistory.sublist(0, _currentStrokeIndex);

          _strokeHistory.add(List<Point>.from(stroke));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Signature Pad'),
          centerTitle: false,
          actions: [
            if (_controller.isNotEmpty) ...[
              IconButton(
                onPressed: () => setState(
                  () => _savedDrawings.add(
                    List<List<Point>>.from(_strokeHistory),
                  ),
                ),
                icon: const Icon(Icons.save),
              ),
            ],
            if (canUndo) ...[
              IconButton(
                onPressed: () => undo(),
                icon: const Icon(Icons.undo),
              ),
            ],
            if (canRedo) ...[
              IconButton(
                onPressed: () => redo(),
                icon: const Icon(Icons.redo),
              ),
            ],
          ],
        ),
        floatingActionButton: _controller.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () => setState(() {
                  _controller.clear();
                  _currentStrokeIndex = _strokeStartIndex;
                }),
                label: const Text('Clear'),
                icon: const Icon(Icons.clear),
              )
            : null,
        body: Stack(
          children: [
            Signature(
              controller: _controller,
              backgroundColor: Colors.blueAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_savedDrawings.isNotEmpty) ...[
                    for (int j = 0; j <= _savedDrawings.length - 1; j++) ...[
                      GestureDetector(
                        onTap: () => setState(
                          () {
                            _controller.clear();

                            _strokeHistory = List<List<Point>>.from(
                              _savedDrawings[j],
                            );

                            _currentStrokeIndex = _strokeHistory.length - 1;

                            for (int i = 0; i <= _currentStrokeIndex; i++) {
                              final stroke = _strokeHistory[i];
                              for (final point in stroke) {
                                _controller.addPoint(point);
                              }
                            }
                          },
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            '${j + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                    ]
                  ]
                ],
              ),
            ),
          ],
        ),
      );

  void undo() => setState(
        () {
          _currentStrokeIndex--;

          _controller.clear();

          for (int i = 0; i <= _currentStrokeIndex; i++) {
            final stroke = _strokeHistory[i];

            for (final point in stroke) {
              _controller.addPoint(point);
            }
          }
        },
      );

  void redo() => setState(
        () {
          if (_currentStrokeIndex == _strokeStartIndex) {
            _currentStrokeIndex = _strokeHistory.length - 1;
          } else {
            _currentStrokeIndex++;
          }

          for (final point in _strokeHistory[_currentStrokeIndex]) {
            _controller.addPoint(point);
          }
        },
      );
}
