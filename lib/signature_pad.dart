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

  final List<List<List<Point>>> _savedDrawings = [];
  List<List<Point>> _strokeHistory = [];

  static const _strokeIndexStart = -1;

  int _currentStrokeIndex = _strokeIndexStart;
  bool get canUndo => _currentStrokeIndex > _strokeIndexStart;
  bool get canRedo => _currentStrokeIndex < _strokeHistory.length - 1;

  @override
  void initState() {
    super.initState();

    _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      onDrawStart: () => setState(
        () {},
      ),
      onDrawEnd: () {
        setState(
          () {
            _currentStrokeIndex++;

            final stroke = _controller.points;

            _strokeHistory = _strokeHistory.sublist(0, _currentStrokeIndex);

            _strokeHistory.add(
              List<Point>.from(stroke),
            );
          },
        );
      },
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
              )
            ],
            if (canUndo) ...[
              IconButton(
                onPressed: () => setState(
                  () => undo(),
                ),
                icon: const Icon(Icons.undo),
              )
            ],
            if (canRedo) ...[
              IconButton(
                onPressed: () => setState(
                  () => redo(),
                ),
                icon: const Icon(Icons.redo),
              )
            ],
          ],
        ),
        floatingActionButton: _controller.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () => setState(
                  () {
                    _currentStrokeIndex = -1;
                    _controller.clear();
                  },
                ),
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
                    for (int i = 0; i < _savedDrawings.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _controller.clear();

                              _strokeHistory =
                                  List<List<Point>>.from(_savedDrawings[i]);

                              _currentStrokeIndex = _strokeHistory.length - 1;

                              for (int j = 0; j < _strokeHistory.length; j++) {
                                final stroke = _strokeHistory[j];
                                for (final point in stroke) {
                                  _controller.addPoint(point);
                                }
                              }
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                    ],
                  ]
                ],
              ),
            )
          ],
        ),
      );

  void redo() => setState(
        () {
          if (_currentStrokeIndex == _strokeIndexStart) {
            _currentStrokeIndex = _strokeHistory.length - 1;
          } else {
            _currentStrokeIndex++;
          }

          for (final point in _strokeHistory[_currentStrokeIndex]) {
            _controller.addPoint(point);
          }
        },
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
}
