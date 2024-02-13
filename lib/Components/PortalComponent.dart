import 'dart:math';

import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/mixin/Indicatable.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../tool/cVectors.dart';
import 'PlayerComponent.dart';

class PortalComponent extends SpriteAnimationComponent
    with
        CollisionCallbacks,
        FlameBlocListenable<PlayerBloc, PlayerState>,
        Indicatable,
        HasGameRef {
  PortalComponent();

  late final SpriteSheet spriteSheet;
  final GlobalKey indicatorKey = GlobalKey();

  late SpriteAnimation Animation =
      spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 8);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = v256;
    add(RectangleHitbox(
        anchor: Anchor.center,
        position: v128,
        size: Vector2(64, 160) * vratio));
    spriteSheet = SpriteSheet(
        image: await Flame.images.load('portal.png'), srcSize: Vector2.all(64));
    animation = Animation;
    angle = -pi / 2;
    anchor = Anchor.center;
  }

  @override
  void onInitialState(PlayerState state) {
    super.onInitialState(state);
    position = state.position + Vector2(0, 180);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is PlayerComponent) {
      other.position = other.position - other.speed * 5;
      gameRef.overlays.add("Leave");
    }
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;

  @override
  bool isActive() {
    if (position.x > camPosition.x + gameRef.size.x / 2 ||
        position.x < camPosition.x - gameRef.size.x / 2 ||
        position.y > camPosition.y + gameRef.size.y / 2 ||
        position.y < camPosition.y - gameRef.size.y / 2) {
      return false;
    }
    return true;
  }

  @override
  GlobalKey get globalKey => indicatorKey;

  @override
  Future<SpriteComponent> indicatorSprite() async {
    return SpriteComponent(
        angle: pi / 2,
        size: v48,
        anchor: Anchor.center,
        position: v128 / 2,
        sprite: await Sprite.load(
          "portal.png",
          srcSize: Vector2.all(64),
        ));
  }
}
