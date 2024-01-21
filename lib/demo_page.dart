import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/examples/body_tracking_page.dart';
import 'package:demos/examples/camera_position_scene.dart';
import 'package:demos/examples/check_support_page.dart';
import 'package:demos/examples/custom_animation_page.dart';
import 'package:demos/examples/custom_light_page.dart';
import 'package:demos/examples/custom_object_page.dart';
import 'package:demos/examples/distance_tracking_page.dart';
import 'package:demos/examples/earth_page.dart';
import 'package:demos/examples/face_detection_page.dart';
import 'package:demos/examples/hello_world.dart';
import 'package:demos/examples/image_detection_page.dart';
import 'package:demos/examples/light_estimate_page.dart';
import 'package:demos/examples/load_gltf_or_glb_page.dart';
import 'package:demos/examples/main.dart';
import 'package:demos/examples/manipulation_page.dart';
import 'package:demos/examples/measure_page.dart';
import 'package:demos/examples/midas_page.dart';
import 'package:demos/examples/network_image_detection.dart';
import 'package:demos/examples/occlusion_page.dart';
import 'package:demos/examples/panorama_page.dart';
import 'package:demos/examples/physics_page.dart';
import 'package:demos/examples/plane_detection_page.dart';
import 'package:demos/examples/real_time_updates.dart';
import 'package:demos/examples/snapshot_scene.dart';
import 'package:demos/examples/tap_page.dart';
import 'package:demos/examples/video_page.dart';
import 'package:demos/examples/widget_projection.dart';
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
  late List<Sample> samples;

  @override
  void initState() {
    super.initState();
    samples = [
      Sample(
        'Hello World',
        'The simplest scene with all geometries.',
        Icons.home,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => HelloWorldPage())),
      ),
      Sample(
        'Check configuration',
        'Shows which kinds of AR configuration are supported on the device',
        Icons.settings,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => CheckSupportPage())),
      ),
      Sample(
        'Earth',
        'Sphere with an image texture and rotation animation.',
        Icons.language,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => EarthPage())),
      ),
      Sample(
        'Tap',
        'Sphere which handles tap event.',
        Icons.touch_app,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => TapPage())),
      ),
      Sample(
        'Midas',
        'Turns walls, floor, and Earth itself into gold by tap.',
        Icons.touch_app,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => MidasPage())),
      ),
      Sample(
        'Plane Detection',
        'Detects horizontal plane.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => PlaneDetectionPage())),
      ),
      Sample(
        'Distance tracking',
        'Detects horizontal plane and track distance on it.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => DistanceTrackingPage())),
      ),
      Sample(
        'Measure',
        'Measures distances',
        Icons.linear_scale,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => MeasurePage())),
      ),
      Sample(
        'Physics',
        'A sphere and a plane with dynamic and static physics',
        Icons.file_download,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => PhysicsPage())),
      ),
      Sample(
        'Image Detection',
        'Detects Earth photo and puts a 3D object near it.',
        Icons.collections,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => ImageDetectionPage())),
      ),
      Sample(
        'Network Image Detection',
        'Detects Mars photo and puts a 3D object near it.',
        Icons.collections,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => NetworkImageDetectionPage())),
      ),
      Sample(
        'Custom Light',
        'Hello World scene with a custom light spot.',
        Icons.lightbulb_outline,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => CustomLightPage())),
      ),
      Sample(
        'Light Estimation',
        'Estimates and applies the light around you.',
        Icons.brightness_6,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => LightEstimatePage())),
      ),
      Sample(
        'Custom Object',
        'Place custom object on plane with coaching overlay.',
        Icons.nature,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => CustomObjectPage())),
      ),
      Sample(
        'Load .gltf or .glb',
        'Load .gltf or .glb from the Flutter assets or the Documents folder',
        Icons.folder_copy,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => LoadGltfOrGlbFilePage())),
      ),
      Sample(
        'Occlusion',
        'Spheres which are not visible after horizontal and vertical planes.',
        Icons.blur_circular,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => OcclusionPage())),
      ),
      Sample(
        'Manipulation',
        'Custom objects with pinch and rotation events.',
        Icons.threed_rotation,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => ManipulationPage())),
      ),
      Sample(
        'Face Tracking',
        'Face mask sample.',
        Icons.face,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => FaceDetectionPage())),
      ),
      Sample(
        'Body Tracking',
        'Dash that follows your hand.',
        Icons.person,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => BodyTrackingPage())),
      ),
      Sample(
        'Panorama',
        '360 photo sample.',
        Icons.panorama,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => PanoramaPage())),
      ),
      Sample(
        'Video',
        '360 video sample.',
        Icons.videocam,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => VideoPage())),
      ),
      Sample(
        'Custom Animation',
        'Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation',
        Icons.accessibility_new,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => CustomAnimationPage())),
      ),
      Sample(
        'Widget Projection',
        'Flutter widgets in AR',
        Icons.widgets,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => WidgetProjectionPage())),
      ),
      Sample(
        'Real Time Updates',
        'Calls a function once per frame',
        Icons.timer,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => RealTimeUpdatesPage())),
      ),
      Sample(
        'Snapshot',
        'Make a photo of AR content',
        Icons.camera,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => SnapshotScenePage())),
      ),
      Sample(
        'Camera position',
        'Get position of the camera in AR scene',
        Icons.location_on,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => CameraPositionScenePage())),
      ),
    ];
  }

  @override
  void dispose() {
    _arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: samples.map((s) => SampleItem(item: s)).toList(),
      ),

      // ARKitSceneView(
      //   onARKitViewCreated: onARKitViewCreated,
      // ),
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
