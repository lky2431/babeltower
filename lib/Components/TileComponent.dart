import 'dart:math';
import 'dart:ui';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class TileComponent extends SpriteComponent with HasGameRef<BabelTowerGame> {
  TileComponent(
      {required this.index, required this.pos, required this.rotation});
  final int index;
  final Vector2 pos;
  final int rotation;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await Flame.images.load('tile.png');
    priority = -10;

    add(
      SpriteComponent(
          sprite: Sprite(image,
              srcPosition: Vector2(16 * index.toDouble(), 0),
              srcSize: Vector2.all(16)),
          size: Vector2(tileSize, tileSize),
          anchor: Anchor.center,
          position: Vector2(tileSize / 2, tileSize / 2),
          angle: rotation * pi / 2),
    );

    sprite =
        Sprite(image, srcPosition: Vector2(16, 0), srcSize: Vector2.all(16));
    size = Vector2(tileSize, tileSize);
    position = pos * tileSize;
    anchor = Anchor.topLeft;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  double get tileSize => gameRef.tileSize;
}
