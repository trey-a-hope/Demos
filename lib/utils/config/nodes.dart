import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/config/planets.dart';
import 'package:vector_math/vector_math_64.dart';

const _metersForward = 1.0;
const _metersUp = 0.0;
const _sizeMultiplier = 0.05;

// TODO: Make space between planets dynamic based on size.

class _EarthNode extends ARKitNode {
  _EarthNode()
      : super(
          eulerAngles: Vector3(100, 0, 0),
          name: 'Earth',
          geometry: ARKitSphere(
            radius: Planets.earth.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.earth.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersLeft: 1.5,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _JupiterNode extends ARKitNode {
  _JupiterNode()
      : super(
          name: 'Jupiter',
          geometry: ARKitSphere(
            radius: Planets.jupiter.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.jupiter.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersLeft: 0.7,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _MarsNode extends ARKitNode {
  _MarsNode()
      : super(
          name: 'Mars',
          geometry: ARKitSphere(
            radius: Planets.mars.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.mars.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersLeft: 1.3,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _MercuryNode extends ARKitNode {
  _MercuryNode()
      : super(
          name: 'Mercury',
          geometry: ARKitSphere(
            radius: Planets.mercury.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.mercury.imgPath),
                doubleSided: true,
              )
            ],
          ),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0),
          position: buildARKitNodePosition(
            metersLeft: 2.5,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _NeptuneNode extends ARKitNode {
  _NeptuneNode()
      : super(
          name: 'Neptune',
          geometry: ARKitSphere(
            radius: Planets.neptune.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.neptune.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersRight: 2,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _SaturnNode extends ARKitNode {
  _SaturnNode()
      : super(
          name: 'Saturn',
          geometry: ARKitSphere(
            radius: Planets.saturn.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.saturn.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersRight: 0.5,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _SunNode extends ARKitNode {
  _SunNode()
      : super(
          name: 'Sun',
          geometry: ARKitSphere(
            radius: Planets.sun.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.sun.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersLeft: 0,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _UranusNode extends ARKitNode {
  _UranusNode()
      : super(
          name: 'Uranus',
          geometry: ARKitSphere(
            radius: Planets.uranus.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.uranus.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersRight: 1.5,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _VenusNode extends ARKitNode {
  _VenusNode()
      : super(
          name: 'Venus',
          geometry: ARKitSphere(
            radius: Planets.venus.size * _sizeMultiplier,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.venus.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: buildARKitNodePosition(
            metersLeft: 2,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class Nodes {
  static final sunNode = _SunNode();
  static final mercuryNode = _MercuryNode();
  static final venusNode = _VenusNode();
  static final earthNode = _EarthNode();
  static final marsNode = _MarsNode();
  static final jupiterNode = _JupiterNode();
  static final saturnNode = _SaturnNode();
  static final uranusNode = _UranusNode();
  static final neptuneNode = _NeptuneNode();
}

/// Generates a Vector3 position for ARKitNode.
/// x negative left; x positive right
/// z negative forward; z positive backward
/// y negative down; y positive up
Vector3 buildARKitNodePosition({
  double metersLeft = 0,
  double metersRight = 0,
  double metersUp = 0,
  double metersDown = 0,
  double metersForward = 0,
  double metersBackward = 0,
}) {
  assert(!(metersRight > 0) || !(metersLeft > 0),
      'Only one horizontal direction can be greater than 0.');

  assert(!(metersUp > 0) || !(metersDown > 0),
      'Only one vertical direction can be greater than 0.');

  assert(!(metersForward > 0) || !(metersBackward > 0),
      'Only one projection direction can be greater than 0.');

  double x = metersRight > 0 ? metersRight : -metersLeft;
  double y = metersUp > 0 ? metersUp : -metersDown;
  double z = metersBackward > 0 ? metersBackward : -metersForward;

  return Vector3(x, y, z);
}
