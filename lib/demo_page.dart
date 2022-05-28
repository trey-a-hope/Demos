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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  bool get _isPlaying =>
      _confettiController.state == ConfettiControllerState.playing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confetti'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                // createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
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
