import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class TileComponent extends SpriteComponent {
  TileComponent(
      {required this.index, required this.pos, required this.rotation});
  final int index;
  final Vector2 pos;
  final int rotation;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await Flame.images.load('tile.png');

    add(
      SpriteComponent(
          sprite: Sprite(image,
              srcPosition: Vector2(16 * index.toDouble(), 0),
              srcSize: Vector2.all(16)),
          size: Vector2(80, 80),
          anchor: Anchor.center,
          position: Vector2(40, 40),
          angle: rotation * pi / 2),
    );

    sprite =
        Sprite(image, srcPosition: Vector2(16, 0), srcSize: Vector2.all(16));
    size = Vector2(80, 80);
    position = pos * 80;
    anchor = Anchor.topLeft;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    // Update game state here
  }
}
