
import 'dart:math';
import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/foundation.dart';

import '../tool/cVectors.dart';

class MosquitoGroupComponent extends PositionComponent
    with HasGameRef<BabelTowerGame> {
  MosquitoGroupComponent({required this.initPosition, required this.speed});
  final Vector2 initPosition;
  final Vector2 speed;
  int indexToCheck = 0;
  AudioPlayer? audioPlayer;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(1000, 1000);
    int mosNum = Random().nextInt(2) + 2;
    for (int i = 0; i < mosNum; i++) {
      add(MosquitoComponent(initPosition: Vector2.random() * 350 * vratio));
    }
    position = initPosition;
    if (speed.x > 0 && speed.y < 0) {
      angle = atan(speed.x / -speed.y);
    } else if (speed.x > 0 && speed.y > 0) {
      angle = atan(speed.x / -speed.y) + pi;
    } else if (speed.x < 0 && speed.y > 0) {
      angle = atan(speed.x / -speed.y) + pi;
    } else if (speed.x < 0 && speed.y < 0) {
      angle = atan(speed.x / -speed.y);
    }
    if (!kIsWeb ){
      audioPlayer = await FlameAudio.play('mosquito.mp3',volume: 0.2);
    }

  }

  @override
  void remove(Component component) {
    super.remove(component);
    audioPlayer?.stop();
    audioPlayer?.release();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += speed * dt * vratio;
    if (indexToCheck >= 20) {
      indexToCheck = 0;
      if (position.x > camPosition.x + gameRef.size.x * 2 / 3 ||
          position.x < camPosition.x - gameRef.size.x * 2 / 3 ||
          position.y > camPosition.y + gameRef.size.y * 2 / 3 ||
          position.y < camPosition.y - gameRef.size.y * 2 / 3) {
        removeFromParent();
      }
    }
    indexToCheck += 1;
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;
}

class MosquitoComponent extends SpriteAnimationComponent
    with CollisionCallbacks, FlameBlocReader<GameBloc, GameState> {
  MosquitoComponent({required this.initPosition});

  final Vector2 initPosition;

  late final SpriteSheet spriteSheet;

  late SpriteAnimation flyAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: 0.02, from: 0, to: 7);

  bool attacking = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = initPosition;
    size = v64;
    add(RectangleHitbox());
    spriteSheet = SpriteSheet(
        image: await Flame.images.load('mosquito.png'),
        srcSize: Vector2.all(64));
    animation = flyAnimation;
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points,other);
    if (other is PlayerComponent) {
      if (!attacking) {
        attacking = true;
        bloc.add(const GameEvent.damage(0.01));
      }
    }
  }
}
