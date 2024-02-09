import 'package:demos/utils/constants/globals.dart';

class CelestialInfo {
  final String name;
  final double size;
  final String imgPath;
  final double spinSpeed;
  final double? orbitSpeed;

  CelestialInfo(
    this.name,
    this.size,
    this.imgPath,
    this.spinSpeed,
    this.orbitSpeed,
  );
}

class _SunInfo extends CelestialInfo {
  _SunInfo()
      : super(
          'Sun',
          0.3,
          Globals.sunDiffuse,
          0.02,
          null,
        );
}

class _MercuryInfo extends CelestialInfo {
  _MercuryInfo()
      : super(
          'Mercury',
          0.1,
          Globals.mercuryDiffuse,
          0.02,
          0.02,
        );
}

class _VenusInfo extends CelestialInfo {
  _VenusInfo()
      : super(
          'Venus',
          0.15,
          Globals.venusDiffuse,
          0.02,
          0.01,
        );
}

class _EarthInfo extends CelestialInfo {
  _EarthInfo()
      : super(
          'Earth',
          0.15,
          Globals.earthDiffuse,
          0.02,
          0.009,
        );
}

class _MarsInfo extends CelestialInfo {
  _MarsInfo()
      : super(
          'Mars',
          0.1,
          Globals.marsDiffuse,
          0.02,
          0.0085,
        );
}

class _JupiterInfo extends CelestialInfo {
  _JupiterInfo()
      : super(
          'Jupiter',
          0.2,
          Globals.jupiterDiffuse,
          0.02,
          0.0080,
        );
}

class _SaturnInfo extends CelestialInfo {
  _SaturnInfo()
      : super(
          'Saturn',
          0.2,
          Globals.saturnDiffuse,
          0.02,
          0.0075,
        );
}

class _UranusInfo extends CelestialInfo {
  _UranusInfo()
      : super(
          'Uranus',
          0.175,
          Globals.uranusDiffuse,
          0.02,
          0.0070,
        );
}

class _NeptuneInfo extends CelestialInfo {
  _NeptuneInfo()
      : super(
          'Neptune',
          0.175,
          Globals.neptuneDiffuse,
          0.02,
          0.0065,
        );
}

const double anchorMultiplier = 0.99;
const double pipeRadius = 0.01;

class Planets {
  static final sun = _SunInfo();
  static final mercury = _MercuryInfo();
  static final venus = _VenusInfo();
  static final earth = _EarthInfo();
  static final mars = _MarsInfo();
  static final jupiter = _JupiterInfo();
  static final saturn = _SaturnInfo();
  static final uranus = _UranusInfo();
  static final neptune = _NeptuneInfo();
}
