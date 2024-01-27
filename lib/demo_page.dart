import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/constants/celestial_info.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:tuple/tuple.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Controller for the ARKitView.
  late ARKitController _arkitController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(
            () => _arkitController.dispose(),
          ),
          child: const Icon(Icons.refresh),
        ),
        body: ARKitSceneView(
          key: UniqueKey(),
          enableTapRecognizer: true,
          enableRotationRecognizer: true,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  /// Builds the ARKitSphere for a planet, moon, or sun.
  ARKitNode _buildCelestialBody({
    required String name,
    required double size,
    required vector.Vector3 position,
    String? imgPath,
  }) =>
      ARKitNode(
        name: name,
        geometry: ARKitSphere(
          radius: size,
          materials: [
            ARKitMaterial(
              diffuse:
                  imgPath == null ? null : ARKitMaterialProperty.image(imgPath),
              doubleSided: true,
            )
          ],
        ),
        position: position,
      );

  /// Returns two nodes, the planet and its anchor inside the root.
  Tuple2<ARKitNode, ARKitNode> _buildNodeConnection({
    required String name,
    required String rootNodeName,
    required double distanceFromRootNode,
    required double size,
    required String imgPath,
  }) {
    final nodeSunAnchor = _buildCelestialBody(
      name: '$name Sun Anchor',
      size: CelestialInfo.sun.size / CelestialInfo.anchorMultiplier,
      position: vector.Vector3.zero(),
    );
    _arkitController.add(nodeSunAnchor, parentNodeName: rootNodeName);

    final nodeAnchor = _buildCelestialBody(
      name: '$name Anchor',
      size: size,
      position: vector.Vector3(0, 0, -distanceFromRootNode),
    );
    _arkitController.add(nodeAnchor, parentNodeName: nodeSunAnchor.name);

    final node = _buildCelestialBody(
      name: name,
      size: size * CelestialInfo.anchorMultiplier,
      imgPath: imgPath,
      position: vector.Vector3.zero(),
    );
    _arkitController.add(node, parentNodeName: nodeAnchor.name);

    final nodeOrbit = _buildOrbitPath(
      ringRadius: nodeAnchor.position.z.abs(),
      pipeRadius: CelestialInfo.pipeRadius,
      color: Colors.white,
    );
    _arkitController.add(nodeOrbit, parentNodeName: rootNodeName);

    return Tuple2<ARKitNode, ARKitNode>(node, nodeSunAnchor);
  }

  /// Builds the ARKitTorus for a ring.
  ARKitNode _buildOrbitPath({
    required double ringRadius, // How wide the ring is.
    required double pipeRadius, // How thick the ring is.
    required Color color,
  }) =>
      ARKitNode(
        geometry: ARKitTorus(
          ringRadius: ringRadius,
          pipeRadius: pipeRadius,
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(color),
            )
          ],
        ),
        position: vector.Vector3.zero(),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    _arkitController = arkitController;

    // Set onTap listener.
    _arkitController.onNodeTap = _onNodeTap;

    /* SUN */

    final sun = CelestialInfo.sun;
    final sunNode = _buildCelestialBody(
      name: sun.name,
      size: sun.size,
      imgPath: sun.imgPath,
      position: vector.Vector3(0, -0.5, -4),
    );
    _arkitController.add(sunNode);

    /* MERCURY */
    final mercury = CelestialInfo.mercury;
    final mercuryNodes = _buildNodeConnection(
      name: mercury.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -0.5,
      size: mercury.size,
      imgPath: mercury.imgPath,
    );

    /* VENUS */
    final venus = CelestialInfo.venus;
    final venusNodes = _buildNodeConnection(
      name: venus.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -1,
      size: venus.size,
      imgPath: venus.imgPath,
    );

    /* EARTH */
    final earth = CelestialInfo.earth;
    final earthNodes = _buildNodeConnection(
      name: earth.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -1.5,
      size: earth.size,
      imgPath: earth.imgPath,
    );

    /* MOON */
    final moonAnchor = _buildCelestialBody(
      name: 'Moon Anchor',
      size: CelestialInfo.moon.size,
      position: vector.Vector3(0, 0, -0.25),
    );
    _arkitController.add(moonAnchor, parentNodeName: earthNodes.item1.name);

    final moon = _buildCelestialBody(
      name: 'Moon',
      size: CelestialInfo.moon.size * CelestialInfo.anchorMultiplier,
      imgPath: CelestialInfo.moon.imgPath,
      position: vector.Vector3.zero(),
    );
    _arkitController.add(moon, parentNodeName: moonAnchor.name);

    /* MARS */
    final mars = CelestialInfo.mars;
    final marsNodes = _buildNodeConnection(
      name: mars.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -2,
      size: mars.size,
      imgPath: mars.imgPath,
    );

    /* JUPITER */
    final jupiter = CelestialInfo.jupiter;
    final jupiterNodes = _buildNodeConnection(
      name: jupiter.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -2.5,
      size: jupiter.size,
      imgPath: jupiter.imgPath,
    );

    /* SATURN */
    final saturn = CelestialInfo.saturn;
    final saturnNodes = _buildNodeConnection(
      name: saturn.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -3,
      size: saturn.size,
      imgPath: saturn.imgPath,
    );

    /* URANUS */
    final uranus = CelestialInfo.uranus;
    final uranusNodes = _buildNodeConnection(
      name: uranus.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -3.5,
      size: uranus.size,
      imgPath: uranus.imgPath,
    );

    /* NEPTUNE */
    final neptune = CelestialInfo.neptune;
    final neptuneNodes = _buildNodeConnection(
      name: neptune.name,
      rootNodeName: sunNode.name,
      distanceFromRootNode: -4,
      size: neptune.size,
      imgPath: neptune.imgPath,
    );

    /// Called once per frame; rotate all nodes.
    /// Rotate node and nodeSunAnchor.
    _arkitController.updateAtTime = (time) {
      _rotateNodeOnXAxis(sunNode, sun.spinSpeed!);
      _rotateNodeOnXAxis(mercuryNodes.item1, mercury.spinSpeed!);
      _rotateNodeOnXAxis(mercuryNodes.item2, mercury.orbitSpeed!);
      _rotateNodeOnXAxis(venusNodes.item1, venus.spinSpeed!);
      _rotateNodeOnXAxis(venusNodes.item2, venus.orbitSpeed!);
      _rotateNodeOnXAxis(earthNodes.item1, earth.spinSpeed!);
      _rotateNodeOnXAxis(earthNodes.item2, earth.orbitSpeed!);
      _rotateNodeOnXAxis(marsNodes.item1, mars.spinSpeed!);
      _rotateNodeOnXAxis(marsNodes.item2, mars.orbitSpeed!);
      _rotateNodeOnXAxis(jupiterNodes.item1, jupiter.spinSpeed!);
      _rotateNodeOnXAxis(jupiterNodes.item2, jupiter.orbitSpeed!);
      _rotateNodeOnXAxis(saturnNodes.item1, saturn.spinSpeed!);
      _rotateNodeOnXAxis(saturnNodes.item2, saturn.orbitSpeed!);
      _rotateNodeOnXAxis(uranusNodes.item1, neptune.spinSpeed!);
      _rotateNodeOnXAxis(uranusNodes.item2, neptune.orbitSpeed!);
      _rotateNodeOnXAxis(neptuneNodes.item1, neptune.spinSpeed!);
      _rotateNodeOnXAxis(neptuneNodes.item2, neptune.orbitSpeed!);
    };
  }

  /*
    Determines the receiver's euler angles. The order of components in this vector matches the axes of rotation:

    Pitch (the x component) is the rotation about the node's x-axis (in radians)
    Yaw (the y component) is the rotation about the node's y-axis (in radians)
    Roll (the z component) is the rotation about the node's z-axis (in radians)
  */
  void _rotateNodeOnXAxis(ARKitNode node, double pitch) {
    // Rotate the node on its x-axis by pitch value.
    node.eulerAngles = node.eulerAngles..x += pitch;
  }

  /// Displays the planets name when tapped.
  void _onNodeTap(List<String> name) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    scaffoldMessengerState.showMaterialBanner(
      MaterialBanner(
        content: Text(name[0]),
        actions: [
          TextButton(
            onPressed: () => scaffoldMessengerState.hideCurrentMaterialBanner(),
            child: const Text('DISMISS'),
          ),
        ],
      ),
    );
  }
}
