import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late ARKitController _arkitController;

  @override
  void dispose() {
    _arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARKitSceneView(
        onARKitViewCreated: onARKitViewCreated,
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    _arkitController = arkitController;
    _arkitController.add(CityViewNode());
  }
}

class CityViewNode extends ARKitNode {
  CityViewNode({double radius = 0.1})
      : super(
          geometry: ARKitSphere(
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Globals.cityViewImage),
                doubleSided: true,
              )
            ],
          ),
          position: Vector3.zero(),
        );
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
