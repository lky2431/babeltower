import 'dart:math';
import 'dart:ui' as ui;

import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/config.dart';
import 'package:babeltower/model/BuildingBlock.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../tool/cVectors.dart';

class BuildingBlockComponent extends PositionComponent with CollisionCallbacks {
  BuildingBlockComponent();
  late final BuildingBlock block;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority = -1;
    block = availableBlocks[Random().nextInt(availableBlocks.length)];
    size = v64 * 3;
    for (int pos in block.blocks) {
      add(_subBlock(
          Vector2(pos % 3, (pos / 3).floor().toDouble()) * 64 * vratio));
      add(RectangleComponent(
          anchor: Anchor.center,
          size: v64 * 1.23,
          position: Vector2(pos % 3 + 0.5, (pos / 3).floor().toDouble() + 0.5) *
              64 *
              vratio,
          paint: Paint()..color = Colors.green.withOpacity(0.6)));
      add(RectangleHitbox(
          size: v64,
          position:
              Vector2(pos % 3, (pos / 3).floor().toDouble()) * 64 * vratio));
    }
    anchor = Anchor.center;
    angle = Random().nextInt(4) * pi / 2;
  }

  @override
  void onMount() {
    super.onMount();
    position = Vector2(Random().nextDouble() * mapSize * 80,
        Random().nextDouble() * mapSize * 80);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is PlayerComponent){

    }
  }
}

class _subBlock extends SpriteComponent {
  _subBlock(this.pos);
  final Vector2 pos;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = v64;
    priority = 1;
    sprite = await Sprite.load(
      "block.png",
      srcSize: Vector2.all(128),
    );
    position = pos;
  }
}
