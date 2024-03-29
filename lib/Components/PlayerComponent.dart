import 'dart:math';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/config.dart';
import 'package:babeltower/model/Goods.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/services.dart';

import '../tool/cVectors.dart';

class PlayerComponent extends SpriteAnimationComponent
    with
        FlameBlocListenable<GameBloc, GameState>,
        KeyboardHandler,
        CollisionCallbacks,
        HasGameRef<BabelTowerGame> {
  PlayerComponent();
  final Vector2 playerDimensions = Vector2(96, 96);
  late SpriteSheet spriteSheet;
  late SpriteAnimation frontAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: 0.03);
  late SpriteAnimation backAnimation =
      spriteSheet.createAnimation(row: 1, stepTime: 0.03);
  late SpriteAnimation sideAnimation =
      spriteSheet.createAnimation(row: 2, stepTime: 0.03);
  late SpriteAnimation idlefrontAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: 10, from: 0, to: 1);
  late SpriteAnimation idlebackAnimation =
      spriteSheet.createAnimation(row: 1, stepTime: 10, from: 0, to: 1);
  late SpriteAnimation idlesideAnimation =
      spriteSheet.createAnimation(row: 2, stepTime: 10, from: 0, to: 1);

  Vector2 speed = Vector2(0, 0);
  bool flipped = false;
  Vector2 previousSpeed = Vector2(0, 0);
  double prevHealth = 1;
  double speedFactor = 100;
  bool haveShoe = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(
        size: Vector2(79 * vratio, 132 * vratio),
        collisionType: CollisionType.passive,
        anchor: Anchor.center,
        position: v128));
    priority = 20;
    spriteSheet = SpriteSheet(
        image: await Flame.images.load('main_ch.png'),
        srcSize: playerDimensions);
    animation = idlebackAnimation;

    anchor = Anchor.center;
    size = v256;
    add(FlameBlocListener<GameBloc, GameState>(onNewState: (state) {
      speed = state.speed;
      if (prevHealth != state.health) {
        decorator.addLast(PaintDecorator.tint(Colors.red.withOpacity(0.2)));
        add(ParticleSystemComponent(
            particle: Particle.generate(
                lifespan: 0.2,
                count: 20,
                generator: (int) {
                  return AcceleratedParticle(
                      position: v128 +
                          Vector2(Random().nextDouble() * 20 - 10,
                              Random().nextDouble() * 20 - 10),
                      acceleration: Vector2(0, 200),
                      speed: Vector2(Random().nextDouble() * 400 - 200,
                          Random().nextDouble() * 400 - 200),
                      child: CircleParticle(
                          radius: 2, paint: Paint()..color = Colors.red));
                })));
        Future.delayed(Duration(milliseconds: 200), () {
          decorator.removeLast();
        });
      }
      prevHealth = state.health;
    }));
    gameRef.camera.follow(this);
  }

  @override
  void onInitialState(GameState state) {
    super.onInitialState(state);
    position = state.position;
    haveShoe = state.goods[allGoods.Shoe]!;
  }

  @override
  void update(double dt) {
    super.update(dt);
    priority = position.y.toInt();
    position += speed * dt * speedFactor * vratio * (haveShoe ? 1.15 : 1);
    if (position.x < 0) {
      position.x = 0;
    }
    if (position.y < 0) {
      position.y = 0;
    }
    if (position.x > mapSize * tileSize) {
      position.x = mapSize * tileSize;
    }
    if (position.y > mapSize * tileSize) {
      position.y = mapSize * tileSize;
    }
    bloc.add(GameEvent.setPosition(position));
    if (speed.x > 0.05) {
      if (!flipped) {
        flipHorizontallyAroundCenter();
        flipped = true;
      }
      animation = sideAnimation;
    } else if (speed.x < -0.05) {
      flipback();
      animation = sideAnimation;
    } else if (speed.y < 0) {
      flipback();
      animation = backAnimation;
    } else if (speed.y > 0) {
      flipback();
      animation = frontAnimation;
    }
    if (speed.x == 0 && speed.y == 0) {
      if (previousSpeed.x.abs() > 0.05) {
        animation = idlesideAnimation;
      } else if (previousSpeed.y > 0) {
        animation = idlefrontAnimation;
      } else if (previousSpeed.y < 0) {
        animation = idlebackAnimation;
      }
    }
    previousSpeed = speed;
  }

  flipback() {
    if (flipped) {
      flipHorizontallyAroundCenter();
      flipped = false;
    }
  }

  @override
  void onNewState(GameState state) {
    super.onNewState(state);
    if (isMounted) {
      speedFactor = 260 - state.weight * 2;
    }
  }

  double get tileSize => gameRef.tileSize;

  @override
  bool onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final up = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final down = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    final left = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final right = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    if (up) {
      bloc.add(GameEvent.move(Vector2(0, -1)));
    }
    if (down) {
      bloc.add(GameEvent.move(Vector2(0, 1)));
    }
    if (left) {
      bloc.add(GameEvent.move(Vector2(-1, 0)));
    }
    if (right) {
      bloc.add(GameEvent.move(Vector2(1, 0)));
    }
    if (keysPressed.isEmpty) {
      bloc.add(GameEvent.move(Vector2(0, 0)));
    }
    return true;
  }
}
