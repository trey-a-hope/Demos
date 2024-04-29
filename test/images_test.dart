import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:demos/my_assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.imgChicago).existsSync(), isTrue);
    expect(File(Images.imgHouston).existsSync(), isTrue);
    expect(File(Images.imgLosAngeles).existsSync(), isTrue);
    expect(File(Images.imgNewYork).existsSync(), isTrue);
    expect(File(Images.imgPhoenix).existsSync(), isTrue);
  });
}
