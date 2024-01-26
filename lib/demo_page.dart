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

    _arkitController.onNodeTap = _onNodeTap;

    // Add the planets to the scene.
    _arkitController.add(Nodes.sunNode);

    // Called once per frame
    _arkitController.updateAtTime = (time) {
      // Rotate the sun.
      _rotateNode(Nodes.sunNode, 0.01);
    };
  }

  /*
    Determines the receiver's euler angles. The order of components in this vector matches the axes of rotation:

    Pitch (the x component) is the rotation about the node's x-axis (in radians)
    Yaw (the y component) is the rotation about the node's y-axis (in radians)
    Roll (the z component) is the rotation about the node's z-axis (in radians)
  */
  void _rotateNode(ARKitNode node, double pitch) {
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
