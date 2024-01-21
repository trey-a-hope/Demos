import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARKitSceneView(
        onARKitViewCreated: (c) {
          c.add(WhiteSphereNode());
          c.add(FaceNode());
          c.add(CapsuleNode());
        },
      ),
    );
  }
}

class WhiteSphereNode extends ARKitNode {
  WhiteSphereNode({double radius = 0.1})
      : super(
          geometry: ARKitSphere(radius: radius),
          position: Vector3(0, 0, -0.5),
        );
}

class FaceNode extends ARKitNode {
  FaceNode({double radius = 0.1})
      : super(
          geometry: ARKitFace(),
          position: Vector3(1, 0, -0.5),
        );
}

class CapsuleNode extends ARKitNode {
  CapsuleNode({double radius = 0.1})
      : super(
          geometry: ARKitCapsule(capRadius: radius),
          position: Vector3(-1, 1, -0.5),
        );
}
