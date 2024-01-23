import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:demos/utils/config/planets.dart';
import 'package:demos/utils/config/builders.dart';

const _metersForward = 1000.0;
const _metersUp = 5.0;
const _metersSolarSystemStart = 500.0;

class _EarthNode extends ARKitNode {
  _EarthNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.earth.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.earth.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: 1,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _JupiterNode extends ARKitNode {
  _JupiterNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.jupiter.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.jupiter.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: 30,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _MarsNode extends ARKitNode {
  _MarsNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.mars.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.mars.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: 60,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _MercuryNode extends ARKitNode {
  _MercuryNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.mercury.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.mercury.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: 300,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _NeptuneNode extends ARKitNode {
  _NeptuneNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.neptune.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.neptune.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: 60,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _SaturnNode extends ARKitNode {
  _SaturnNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.saturn.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.saturn.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: _metersSolarSystemStart,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _SunNode extends ARKitNode {
  _SunNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.sun.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.sun.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: _metersSolarSystemStart,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _UranusNode extends ARKitNode {
  _UranusNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.uranus.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.uranus.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: _metersSolarSystemStart,
            metersUp: _metersUp,
            metersForward: _metersForward,
          ),
        );
}

class _VenusNode extends ARKitNode {
  _VenusNode()
      : super(
          geometry: ARKitSphere(
            radius: Planets.venus.size,
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialProperty.image(Planets.venus.imgPath),
                doubleSided: true,
              )
            ],
          ),
          position: Builders.buildARKitNodePosition(
            metersLeft: _metersSolarSystemStart,
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
