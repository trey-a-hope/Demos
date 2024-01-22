import 'package:vector_math/vector_math_64.dart';

extension Vector3Extensions on Vector3 {
  // x negative left; x positive right
  // z negative forward; z positive backward
  // y negative down; y positive up
  Vector3 arKitNodePosition({
    double? metersLeft,
    double? metersRight,
    double? metersUp,
    double? metersDown,
    double? metersForward,
    double? metersBackward,
  }) {
    // Set horizontal distance.
    assert(metersRight == null || metersLeft == null);
    assert(metersRight != null || metersLeft != null);

    double x = metersRight ?? -metersLeft!;

    // Set vertical distance.
    assert(metersUp == null || metersDown == null);
    assert(metersUp != null || metersDown != null);

    double y = metersUp ?? -metersDown!;

    // Set projection distance.
    assert(metersBackward == null || metersForward == null);
    assert(metersBackward != null || metersForward != null);

    double z = metersBackward ?? -metersForward!;

    return Vector3(x, y, z);
  }
}
