import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Confetti controller.
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 10));

  /// Party color set.
  static const List<Color> _colorSetParty = [
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.purple,
  ];

  /// Black and white color set.
  static const List<Color> _colorSetBW = [Colors.black, Colors.grey];

  /// Flag that represents if the confetti is playing.
  bool get _isPlaying =>
      _confettiController.state == ConfettiControllerState.playing;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confetti'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // The confetti widget.
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                // The [blastDirection] is a radial value to determine the direction of the particle emission.
                blastDirection: pi,

                // The [blastDirectionality] is an enum that takes one of two values - directional or explosive.
                blastDirectionality: BlastDirectionality.explosive,

                // An optional parameter to specify the area size where the confetti will be thrown. By default this is set to then screen size.
                canvas: Size.infinite,

                child: null,
                colors: _colorSetParty,
                confettiController: _confettiController,
                createParticlePath: (Size size) {
                  double degToRad(double deg) => deg * (pi / 180.0);

                  const numberOfPoints = 5;
                  final halfWidth = size.width / 2;
                  final externalRadius = halfWidth;
                  final internalRadius = halfWidth / 2.5;
                  final degreesPerStep = degToRad(360 / numberOfPoints);
                  final halfDegreesPerStep = degreesPerStep / 2;
                  final path = Path();
                  final fullAngle = degToRad(360);

                  path.moveTo(size.width, halfWidth);

                  for (double step = 0;
                      step < fullAngle;
                      step += degreesPerStep) {
                    path.lineTo(halfWidth + externalRadius * cos(step),
                        halfWidth + externalRadius * sin(step));
                    path.lineTo(
                        halfWidth +
                            internalRadius * cos(step + halfDegreesPerStep),
                        halfWidth +
                            internalRadius * sin(step + halfDegreesPerStep));
                  }
                  path.close();
                  return path;
                },
                displayTarget: false,
                emissionFrequency: 0.02,
                gravity: 0.2,
                maximumSize: const Size(30, 15),
                minimumSize: const Size(20, 10),
                maxBlastForce: 20,
                minBlastForce: 5,
                numberOfParticles: 10,
                particleDrag: 0.05,
                strokeColor: Colors.black,
                strokeWidth: 0,
                shouldLoop: true,
              ),
            ),
            // Text displaying 'Confetti is active/deactive'.
            Align(
              alignment: Alignment.center,
              child: Text(
                'Confetti is ${_isPlaying ? 'active' : 'deactive'}.',
                style: TextStyle(
                  color: _isPlaying ? Colors.green : Colors.red,
                  fontSize: 21,
                ),
              ),
            ),
            // Play and Stop buttons for the confetti.
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text('Play'),
                    onPressed: () {
                      _confettiController.play();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                  ElevatedButton(
                    child: Text('Stop'),
                    onPressed: () {
                      _confettiController.stop();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
