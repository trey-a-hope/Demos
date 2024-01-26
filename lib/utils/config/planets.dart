import 'package:demos/utils/constants/globals.dart';

// https://www.solarsystemscope.com/textures/
// https://www.universetoday.com/36649/planets-in-order-of-size/#google_vignette

class _Planet {
  final String name;
  final double size;
  final String imgPath;

  _Planet({
    required this.name,
    required this.size,
    required this.imgPath,
  });
}

class _Earth extends _Planet {
  _Earth()
      : super(
          name: 'Earth',
          size: 1.0,
          imgPath: Globals.earthImage,
        );
}

class _Jupiter extends _Planet {
  _Jupiter()
      : super(
          name: 'Jupiter',
          size: 11.2,
          imgPath: Globals.jupiterImage,
        );
}

class _Mars extends _Planet {
  _Mars()
      : super(
          name: 'Mars',
          size: 0.53,
          imgPath: Globals.marsImage,
        );
}

class _Mercury extends _Planet {
  _Mercury()
      : super(
          name: 'Mercury',
          size: 0.38,
          imgPath: Globals.mercuryImage,
        );
}

class _Neptune extends _Planet {
  _Neptune()
      : super(
          name: 'Neptune',
          size: 3.38,
          imgPath: Globals.neptuneImage,
        );
}

class _Saturn extends _Planet {
  _Saturn()
      : super(
          name: 'Saturn',
          size: 9.45,
          imgPath: Globals.saturnImage,
        );
}

class _Sun extends _Planet {
  _Sun()
      : super(
          name: 'Sun',
          size: 1, // 218
          imgPath: Globals.sunImage,
        );
}

class _Uranus extends _Planet {
  _Uranus()
      : super(
          name: 'Uranus',
          size: 4,
          imgPath: Globals.uranusImage,
        );
}

class _Venus extends _Planet {
  _Venus()
      : super(
          name: 'Venus',
          size: 0.95,
          imgPath: Globals.venusImage,
        );
}

class Planets {
  static final earth = _Earth();
  static final jupiter = _Jupiter();
  static final mars = _Mars();
  static final mercury = _Mercury();
  static final neptune = _Neptune();
  static final saturn = _Saturn();
  static final sun = _Sun();
  static final uranus = _Uranus();
  static final venus = _Venus();
}
