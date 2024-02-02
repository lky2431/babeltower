import 'dart:ui';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/bloc/player_bloc.dart';
import 'package:babeltower/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PlayerComponent extends SpriteAnimationComponent
    with
        FlameBlocReader<PlayerBloc, PlayerState>,
        KeyboardHandler,
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
  Vector2 speed = Vector2(0, 0);
  bool flipped = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority = 20;
    spriteSheet = SpriteSheet(
        image: await Flame.images.load('main_ch.png'),
        srcSize: playerDimensions);
    animation = backAnimation;
    position = bloc.state.position;
    anchor = Anchor.center;

    size = Vector2(256, 256);

    add(FlameBlocListener<PlayerBloc, PlayerState>(onNewState: (state) {
      speed = state.speed;
    }));
    gameRef.camera.follow(this);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += speed * dt * 150;
    if (position.x < 0) {
      position.x = 0;
    }
    if (position.y < 0) {
      position.y = 0;
    }
    if (position.x > mapSize * 80) {
      position.x = mapSize * 80;
    }
    if (position.y > mapSize * 80) {
      position.y = mapSize * 80;
    }
    bloc.add(PlayerEvent.setPosition(position));

    if (speed.x > 0) {
      if (!flipped) {
        flipHorizontallyAroundCenter();
        flipped = true;
      }
      animation = sideAnimation;
    } else if (speed.x < 0) {
      flipback();
      animation = sideAnimation;
    } else if (speed.y < 0) {
      flipback();
      animation = backAnimation;
    } else if (speed.y > 0) {
      flipback();
      animation = frontAnimation;
    }
  }

  flipback() {
    if (flipped) {
      flipHorizontallyAroundCenter();
      flipped = false;
    }
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final up = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final down = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    final left = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final right = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    if (up) {
      bloc.add(PlayerEvent.move(Vector2(0, -1)));
    }
    if (down) {
      bloc.add(PlayerEvent.move(Vector2(0, 1)));
    }
    if (left) {
      bloc.add(PlayerEvent.move(Vector2(-1, 0)));
    }
    if (right) {
      bloc.add(PlayerEvent.move(Vector2(1, 0)));
    }
    if (keysPressed.isEmpty) {
      //bloc.add(PlayerEvent.move(Vector2(0,0)));
    }
    return true;
  }

  @override
  void onRemove() {}
}
