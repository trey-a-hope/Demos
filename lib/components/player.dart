import 'package:demos/constants/globals.dart';
import 'package:demos/game/space_shooter_game.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  final double spriteHeight = 200;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.playerSprite);

    position = gameRef.size / 2;
    width = spriteHeight * 1.42;
    height = spriteHeight;
    anchor = Anchor.center;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
