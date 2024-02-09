import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/constants/celestial_info.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late ARKitController _arKitController;

  @override
  void dispose() {
    _arKitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(
            () => _arKitController.dispose(),
          ),
          child: const Icon(Icons.refresh),
        ),
        body: ARKitSceneView(
          key: UniqueKey(),
          enableTapRecognizer: true,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  ARKitNode _buildCelestialBody(
    String name,
    double size,
    String imgPath,
    vm.Vector3 position,
  ) =>
      ARKitNode(
        name: name,
        geometry: ARKitSphere(
          radius: size,
          materials: [
            ARKitMaterial(diffuse: ARKitMaterialProperty.image(imgPath))
          ],
        ),
        position: position,
      );

  ARKitNode _buildOrbit(ARKitNode node) => ARKitNode(
        name: '${node.name} Orbit',
        geometry: ARKitTorus(
          ringRadius: node.position.z.abs(),
          pipeRadius: pipeRadius,
        ),
        position: vm.Vector3.zero(),
      );

  void _onNodeTap(List<String> names) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    scaffoldMessengerState.showMaterialBanner(
      MaterialBanner(
        content: Text(
          names[0],
        ),
        actions: [
          TextButton(
            onPressed: () => scaffoldMessengerState.hideCurrentMaterialBanner(),
            child: const Text('DISMISS'),
          )
        ],
      ),
    );
  }

  Tuple2 _buildConnection(CelestialInfo c, double distanceFromSun) {
    final nodeSunAnchor = _buildCelestialBody(
      '${c.name} Sun Anchor',
      Planets.sun.size * anchorMultiplier,
      Planets.sun.imgPath,
      vm.Vector3(0, 0, -3),
    );

    _arKitController.add(nodeSunAnchor);

    final nodeAnchor = _buildCelestialBody(
      '${c.name} Anchor',
      c.size * anchorMultiplier,
      c.imgPath,
      vm.Vector3(0, 0, -distanceFromSun),
    );

    _arKitController.add(nodeAnchor, parentNodeName: nodeSunAnchor.name);

    final node = _buildCelestialBody(
      c.name,
      c.size,
      c.imgPath,
      vm.Vector3.zero(),
    );

    _arKitController.add(node, parentNodeName: nodeAnchor.name);

    final orbit = _buildOrbit(nodeAnchor);

    _arKitController.add(orbit, parentNodeName: Planets.sun.name);

    return Tuple2(nodeAnchor, nodeSunAnchor);
  }

  void onARKitViewCreated(ARKitController arKitController) {
    _arKitController = arKitController;

    _arKitController.onNodeTap = _onNodeTap;

    final sun = _buildCelestialBody(
      Planets.sun.name,
      Planets.sun.size,
      Planets.sun.imgPath,
      vm.Vector3(0, 0, -3),
    );

    _arKitController.add(sun);

    final mercuryNodes = _buildConnection(
      Planets.mercury,
      0.5,
    );

    final venusNodes = _buildConnection(
      Planets.venus,
      1,
    );

    final earthNodes = _buildConnection(
      Planets.earth,
      1.5,
    );
    final marsNodes = _buildConnection(
      Planets.mars,
      2,
    );
    final jupiterNodes = _buildConnection(
      Planets.jupiter,
      2.5,
    );
    final saturnNodes = _buildConnection(
      Planets.saturn,
      3,
    );

    final uranusNodes = _buildConnection(
      Planets.uranus,
      3.5,
    );
    final neptuneNodes = _buildConnection(
      Planets.neptune,
      4,
    );

    _arKitController.updateAtTime = (time) {
      _rotateOnXAxis(sun, Planets.sun.spinSpeed);
      _rotateOnXAxis(mercuryNodes.item1, Planets.mercury.spinSpeed);
      _rotateOnXAxis(mercuryNodes.item2, Planets.mercury.orbitSpeed!);
      _rotateOnXAxis(venusNodes.item1, Planets.venus.spinSpeed);
      _rotateOnXAxis(venusNodes.item2, Planets.venus.orbitSpeed!);
      _rotateOnXAxis(earthNodes.item1, Planets.earth.spinSpeed);
      _rotateOnXAxis(earthNodes.item2, Planets.earth.orbitSpeed!);
      _rotateOnXAxis(marsNodes.item1, Planets.mars.spinSpeed);
      _rotateOnXAxis(marsNodes.item2, Planets.mars.orbitSpeed!);
      _rotateOnXAxis(jupiterNodes.item1, Planets.jupiter.spinSpeed);
      _rotateOnXAxis(jupiterNodes.item2, Planets.jupiter.orbitSpeed!);
      _rotateOnXAxis(saturnNodes.item1, Planets.saturn.spinSpeed);
      _rotateOnXAxis(saturnNodes.item2, Planets.saturn.orbitSpeed!);
      _rotateOnXAxis(uranusNodes.item1, Planets.uranus.spinSpeed);
      _rotateOnXAxis(uranusNodes.item2, Planets.uranus.orbitSpeed!);
      _rotateOnXAxis(neptuneNodes.item1, Planets.neptune.spinSpeed);
      _rotateOnXAxis(neptuneNodes.item2, Planets.neptune.orbitSpeed!);
    };
  }

  void _rotateOnXAxis(ARKitNode node, double pitch) {
    node.eulerAngles = node.eulerAngles..x += pitch;
  }
}
