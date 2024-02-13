import 'dart:math';
import 'dart:ui' as ui;

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/config.dart';
import 'package:babeltower/mixin/Indicatable.dart';
import 'package:babeltower/model/BuildingBlock.dart';
import 'package:babeltower/model/Goods.dart';
import 'package:babeltower/model/PickableItem.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../tool/cVectors.dart';

class BuildingBlockComponent extends PositionComponent
    with
        CollisionCallbacks,
        FlameBlocListenable<PlayerBloc, PlayerState>,
        Indicatable,
        HasGameRef<BabelTowerGame> {
  BuildingBlockComponent({required this.index, required this.initialPosition});
  final int index;
  final Vector2 initialPosition;
  bool picking = false;

  final GlobalKey indicatorKey = GlobalKey();
  bool havePhone = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority = -1;
    size = v64 * 3;
    for (int pos in availableBlocks[index]!.blocks) {
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
    position = initialPosition;
  }

  @override
  void onInitialState(PlayerState state) {
    super.onInitialState(state);
    havePhone = state.goods[allGoods.Phone]!;
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlayerComponent && !picking) {
      picking = true;
      PickableItem item = PickableItem.building("block to build tower", index,
          availableBlocks[index]!.blocks.length * 2);
      String? result = bloc.shouldPick(item);
      if (result == null) {
        gameRef.indicatorManager.removeComponent(indicatorKey);
        removeFromParent();
        bloc.add(PlayerEvent.pick(item));
      } else {
        gameRef.overlays.add(result);
        Future.delayed(Duration(seconds: 3), () {
          picking = false;
        });
      }
    }
  }

  @override
  GlobalKey<State<StatefulWidget>> get globalKey => indicatorKey;

  @override
  Future<SpriteComponent> indicatorSprite() async {
    return SpriteComponent(
        angle: pi / 2,
        size: v48,
        anchor: Anchor.center,
        position: v128 / 2,
        sprite: await Sprite.load(
          "block.png",
          srcSize: Vector2.all(128),
        ));
  }

  @override
  bool isActive() {
    if (!havePhone) {
      return true;
    }
    if (position.x > camPosition.x + gameRef.size.x / 2 ||
        position.x < camPosition.x - gameRef.size.x / 2 ||
        position.y > camPosition.y + gameRef.size.y / 2 ||
        position.y < camPosition.y - gameRef.size.y / 2) {
      return false;
    }
    return true;
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
