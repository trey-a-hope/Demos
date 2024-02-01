import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/constants/celestial_info.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late ARKitController _arKitController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _arKitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(arKitController) {
    _arKitController = arKitController;

    final sun = _buildCelestialBody(
      Planets.sun.name,
      Planets.sun.size,
      Planets.sun.imgPath,
      vm.Vector3(0, 0, -3),
    );

    _arKitController.add(sun);

    final mercurySunAnchor = _buildCelestialBody(
      '${Planets.mercury.name} Sun Anchor',
      Planets.mercury.size * anchorMultiplier,
      Planets.mercury.imgPath,
      vm.Vector3.zero(),
    );
    _arKitController.add(mercurySunAnchor, parentNodeName: Planets.sun.name);

    final mercuryAnchor = _buildCelestialBody(
      '${Planets.mercury.name} Anchor',
      Planets.mercury.size * anchorMultiplier,
      Planets.mercury.imgPath,
      vm.Vector3(0, 0, -0.5),
    );
    _arKitController.add(mercuryAnchor, parentNodeName: mercurySunAnchor.name);

    final mercury = _buildCelestialBody(
      Planets.mercury.name,
      Planets.mercury.size,
      Planets.mercury.imgPath,
      vm.Vector3.zero(),
    );
    _arKitController.add(mercury, parentNodeName: mercuryAnchor.name);

    final orbit = _buildOrbitPath(mercuryAnchor);

    _arKitController.add(orbit, parentNodeName: Planets.sun.name);

    _arKitController.updateAtTime = (time) {
      _rotateNodeOnXAxis(sun, Planets.sun.spinSpeed!);
      _rotateNodeOnXAxis(mercury, Planets.mercury.spinSpeed!);
      _rotateNodeOnXAxis(mercurySunAnchor, Planets.mercury.orbitSpeed!);
    };
  }

  ARKitNode _buildOrbitPath(ARKitNode node) => ARKitNode(
        name: '${node.name} Orbit',
        geometry: ARKitTorus(
          ringRadius: node.position.z.abs(),
          pipeRadius: pipeRadius,
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.white),
            ),
          ],
        ),
        position: vm.Vector3.zero(),
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
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.image(
                imgPath,
              ),
            )
          ],
        ),
        position: position,
      );

  void _rotateNodeOnXAxis(ARKitNode node, double pitch) {
    node.eulerAngles = node.eulerAngles..x += pitch;
  }
}
