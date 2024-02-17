import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:babeltower/tool/cVectors.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/player/player_bloc.dart';
import 'PlayerComponent.dart';

class ExplosionComponent extends PositionComponent
    with CollisionCallbacks, FlameBlocReader<GameBloc, GameState> {
  ExplosionComponent({required this.initPosition});

  final Vector2 initPosition;

  late final SpriteSheet spriteSheet;

  late SpriteAnimation explodeAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: 0.05, from: 0, to: 12);
  bool attacking = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    double randomSize = (Random().nextInt(120) + 50) * vratio;
    size = Vector2.all(randomSize * 4);
    anchor = Anchor.center;
    priority = 50000;
    position = initPosition;
    CircleComponent circle = CircleComponent(
        radius: randomSize,
        paint: Paint()..color = Color(0xFF6C0011).withOpacity(0),
        anchor: Anchor.center);
    add(circle);
    spriteSheet = SpriteSheet(
        image: await Flame.images.load('explosion.png'),
        srcSize: Vector2.all(64));
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (timer.tick * 0.4 / 10 > 1) {
        return;
      }
      circle.paint = Paint()
        ..color = const Color(0xFF6C0011).withOpacity(timer.tick * 0.4 / 10);
    });

    Future.delayed(Duration(seconds: 2), () {
      //FlameAudio.play('explosion.mp3');
      remove(circle);
      add(SpriteAnimationComponent(
          animation: explodeAnimation,
          size: Vector2.all(randomSize * 4),
          anchor: Anchor.center));
      add(CircleHitbox(radius: randomSize * 1.2, anchor: Anchor.center));
    });
    Future.delayed(Duration(milliseconds: 2000 + 550), () {
      removeFromParent();
    });
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is PlayerComponent) {
      if (!attacking) {
        attacking = true;
        bloc.add(const GameEvent.damage(0.05));
      }
    }
  }

}
