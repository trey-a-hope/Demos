import 'package:vector_math/vector_math_64.dart';

class Builders {
  // x negative left; x positive right
  // z negative forward; z positive backward
  // y negative down; y positive up
  static Vector3 buildARKitNodePosition({
    double metersLeft = 0,
    double metersRight = 0,
    double metersUp = 0,
    double metersDown = 0,
    double metersForward = 0,
    double metersBackward = 0,
  }) {
    assert(metersRight > 0 || metersLeft > 0,
        'Either metersRight or metersLeft must be greater than 0.');
    assert(!(metersRight > 0) || !(metersLeft > 0),
        'Only one horizontal direction can be greater than 0.');

    assert(metersUp > 0 || metersDown > 0,
        'Either metersUp or metersDown must be greater than 0.');
    assert(!(metersUp > 0) || !(metersDown > 0),
        'Only one vertical direction can be greater than 0.');

    assert(metersForward > 0 || metersBackward > 0,
        'Either metersForward or metersBackward must be greater than 0.');
    assert(!(metersForward > 0) || !(metersBackward > 0),
        'Only one projection direction can be greater than 0.');

    double x = metersRight > 0 ? metersRight : -metersLeft;
    double y = metersUp > 0 ? metersUp : -metersDown;
    double z = metersBackward > 0 ? metersBackward : -metersForward;

    return Vector3(x, y, z);
  }
}
