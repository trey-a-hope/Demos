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

                // An optional parameter to specify the area size where the confetti will be thrown.
                // By default this is set to then screen size.
                canvas: Size.infinite,

                // Child widget to display
                child: null,

                // List of Colors to iterate over - if null then random values will be chosen
                colors: _colorSetParty,

                // Controls the animation.
                confettiController: _confettiController,

                // The [createParticlePath] is optional function that returns custom Path needed to generate particles.
                // The default function returns rectangular path
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

                // The [displayTarget] attribute determines if a crosshair will be displayed to 
                // show the location of the particle emitter.
                displayTarget: false,

                // The [emissionFrequency] should be a value between 0 and 1.
                // The higher the value the higher the likelihood that particles will be emitted on a single frame.
                // Default is set to `0.02` (2% chance).
                emissionFrequency: 0.02,

                // The [gravity] is the speed at which the confetti will fall.
                // The higher the [gravity] the faster it will fall.
                // It can be set to a value between `0` and `1`
                // Default value is `0.1`
                gravity: 0.2,


                // An optional parameter to set the maximum potential size for the confetti.
                // Must be bigger than the [minimumSize] attribute.
                
                maximumSize: const Size(30, 15),

                // An optional parameter to set the minimum size potential size for the confetti.
                // Must be smaller than the [maximumSize] attribute.
                minimumSize: const Size(20, 10),

                // The [maxBlastForce] and [minBlastForce] will determine the maximum and
                // minimum blast force applied to  a particle within it's first 5 frames of
                // life. The default [maxBlastForce] is set to `20`
                maxBlastForce: 20,    

                // The [maxBlastForce] and [minBlastForce] will determine the maximum and
                // minimum blast force applied to a particle within it's first 5 frames of
                // life. The default [minBlastForce] is set to `5`  
                minBlastForce: 5,

                // The [numberOfParticles] to be emitted per emission.
                // Default is set to `10`.
                numberOfParticles: 10,

                // An optional parameter to specify drag force, effecting the movement of the confetti.
                // Using `1.0` will give no drag at all, while, for example, using `0.1`
                // will give a lot of drag. Default is set to `0.05`.
                particleDrag: 0.05,

                // Stroke color of the confetti (black by default, requires a strokeWidth > 0)
                strokeColor: Colors.black,

                // Stroke width of the confetti (0.0 by default, no stroke)
                strokeWidth: 0,   

                // The [shouldLoop] attribute determines if the animation will
                // reset once it completes, resulting in a continuous particle emission.
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
