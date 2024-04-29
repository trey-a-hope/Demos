import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:demos/my_assets/resources.dart';

void main() {
  test('sounds assets test', () {
    expect(File(Sounds.soundBreakBlock).existsSync(), isTrue);
    expect(File(Sounds.soundBump).existsSync(), isTrue);
    expect(File(Sounds.soundJumpSmall).existsSync(), isTrue);
    expect(File(Sounds.soundPause).existsSync(), isTrue);
    expect(File(Sounds.soundPowerupAppears).existsSync(), isTrue);
  });
}
