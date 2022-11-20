import 'package:demos/components/player.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class SpaceShooterGame extends FlameGame with PanDetector {
  Player player = Player();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
}
