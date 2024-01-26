import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/config/nodes.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARKitSceneView(
        enableTapRecognizer: true,
        enableRotationRecognizer: true,
        onARKitViewCreated: onARKitViewCreated,
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    _arkitController = arkitController;

    // Set onTap listener.
    _arkitController.onNodeTap = _onNodeTap;

    // Add the Sun.
    _arkitController.add(Nodes.sunNode);

    // Add Earth as a child of the Sun, to rotate the Sun.
    _arkitController.add(Nodes.earthParentNode,
        parentNodeName: Nodes.sunNode.name);

    // Add Earth as child of itself, to rotate itself.
    _arkitController.add(Nodes.earthChildNode,
        parentNodeName: Nodes.earthParentNode.name);

    // Called once per frame.
    _arkitController.updateAtTime = (time) {
      // Rotate the sun.
      _rotateNodeOnXAxis(Nodes.sunNode, 0.01);
      // Rotate the earth around the sun, (same speed as the sun's rotation).
      _rotateNodeOnXAxis(Nodes.earthParentNode, 0.01);
      // Rotate the earth on its own axis, (slower speed than its parent and the Sun).
      _rotateNodeOnXAxis(Nodes.earthChildNode, 0.001);
    };
  }

  //TODO: YouTube Video Stopped @ 31:14

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
