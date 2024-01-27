import 'package:demos/utils/constants/globals.dart';

class _CelestialInfo {
  final String name;
  final double size;
  final String imgPath;
  final double? spinSpeed;
  final double? orbitSpeed;

  _CelestialInfo(
    this.name,
    this.size,
    this.imgPath,
    this.spinSpeed,
    this.orbitSpeed,
  );
}

class _SunInfo extends _CelestialInfo {
  _SunInfo() : super('Sun', 0.3, Globals.sunDiffuse, 0.02, null);
}

class _MercuryInfo extends _CelestialInfo {
  _MercuryInfo() : super('Mercury', 0.1, Globals.mercuryDiffuse, 0.02, 0.02);
}

class _VenusInfo extends _CelestialInfo {
  _VenusInfo() : super('Venus', 0.15, Globals.venusDiffuse, 0.02, 0.01);
}

class _EarthInfo extends _CelestialInfo {
  _EarthInfo() : super('Earth', 0.15, Globals.earthDiffuse, 0.02, 0.005);
}

class _MoonInfo extends _CelestialInfo {
  _MoonInfo() : super('Moon', 0.05, Globals.moonDiffuse, null, null);
}

class _MarsInfo extends _CelestialInfo {
  _MarsInfo() : super('Mars', 0.1, Globals.marsDiffuse, 0.02, 0.0025);
}

class _JupiterInfo extends _CelestialInfo {
  _JupiterInfo() : super('Jupiter', 0.2, Globals.jupiterDiffuse, 0.02, 0.00125);
}

class _SaturnInfo extends _CelestialInfo {
  _SaturnInfo() : super('Saturn', 0.2, Globals.jupiterDiffuse, 0.02, 0.000625);
}

class _UranusInfo extends _CelestialInfo {
  _UranusInfo()
      : super('Uranus', 0.175, Globals.uranusDiffuse, 0.02, 0.0003125);
}

class _NeptuneInfo extends _CelestialInfo {
  _NeptuneInfo()
      : super('Neptune', 0.175, Globals.uranusDiffuse, 0.02, 0.000015625);
}

class CelestialInfo {
  // Mulitipliers.
  static const double anchorMultiplier = 1.01;
  static const double pipeRadius = 0.01;

  static final sun = _SunInfo();
  static final mercury = _MercuryInfo();
  static final venus = _VenusInfo();
  static final earth = _EarthInfo();
  static final moon = _MoonInfo();
  static final mars = _MarsInfo();
  static final jupiter = _JupiterInfo();
  static final saturn = _SaturnInfo();
  static final uranus = _UranusInfo();
  static final neptune = _NeptuneInfo();
}
