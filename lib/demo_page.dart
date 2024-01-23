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
        onARKitViewCreated: onARKitViewCreated,
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    _arkitController = arkitController;
    _arkitController.add(Nodes.sunNode);
    _arkitController.add(Nodes.mercuryNode);
    // _arkitController.add(Nodes.venusNode);
    // _arkitController.add(Nodes.earthNode);
    // _arkitController.add(Nodes.marsNode);
    // _arkitController.add(Nodes.jupiterNode);
    // _arkitController.add(Nodes.saturnNode);
    // _arkitController.add(Nodes.uranusNode);
    // _arkitController.add(Nodes.neptuneNode);
  }
}
