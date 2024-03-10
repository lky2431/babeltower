import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/Components/SpawnEnemyComponent.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/foundation.dart';

import '../bloc/player/player_bloc.dart';
import '../tool/cVectors.dart';

class ZombieComponent extends SpriteAnimationComponent
    with
        FlameBlocListenable<GameBloc, GameState>,
        CollisionCallbacks,
        HasGameRef<BabelTowerGame>,
        ParentIsA<SpawnEnemyComponent> {
  ZombieComponent(this._position, {required this.onDestroyed});

  late final SpriteSheet spriteSheet;
  late SpriteAnimation idleAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: 0.2, from: 0, to: 2);
  late SpriteAnimation moveAnimation =
      spriteSheet.createAnimation(row: 1, stepTime: 0.15, from: 0, to: 8);
  late SpriteAnimation attackAnimation =
      spriteSheet.createAnimation(row: 2, stepTime: 0.2, from: 0, to: 3);

  final Vector2 _position;
  late Vector2 _playerPosition;
  bool flip = false;
  late Vector2 _size;
  final Function onDestroyed;
  bool attacking = false;
  int outboundToCheck = 0;
  int speedToCheck = 10;
  Vector2 speed = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = v196;
    add(RectangleHitbox(size: v128));
    position = _position;
    spriteSheet = SpriteSheet(
        image: await Flame.images.load('zombie.png'), srcSize: Vector2(32, 32));
    animation = moveAnimation;
    anchor = Anchor.center;
    _size = gameRef.size;
  }

  @override
  void update(double dt) {
    super.update(dt);
    priority = position.y.toInt();
    if (!attacking) {
      position += speed * dt;
    }
    if (speedToCheck >= 10) {
      speed = (_playerPosition - position).normalized() * 140 * vratio;

      if (speed.x > 0 && flip) {
        flipHorizontallyAroundCenter();
        flip = false;
      } else if (speed.x < 0 && !flip) {
        flipHorizontallyAroundCenter();
        flip = true;
      }
      speedToCheck = 0;
    }
    speedToCheck += 1;

    if (outboundToCheck > 20) {
      if (camPosition.x + _size.x * 0.8 < position.x ||
          camPosition.x - _size.x * 0.8 > position.x ||
          camPosition.y + _size.y * 0.8 < _position.y &&
              camPosition.y - _size.y * 0.8 > position.y) {
        onDestroyed();
        removeFromParent();
      }
      outboundToCheck = 0;
    }
    outboundToCheck += 1;
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is ZombieComponent) {
      position += (position - other.position) * 0.01;
    } else if (other is PlayerComponent) {
      if (!attacking) {
        animation = attackAnimation;
        attacking = true;
        if (!kIsWeb) {
          FlameAudio.play('zombie.mp3', volume: 0.1);
        }

        Future.delayed(Duration(milliseconds: 600), () {
          animation = moveAnimation;
          attacking = false;
        });
        bloc.add(GameEvent.damage(0.01));
      }
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _size = size;
  }

  @override
  void onInitialState(GameState state) {
    super.onInitialState(state);
    _playerPosition = state.position;
  }

  @override
  void onNewState(GameState state) {
    super.onNewState(state);
    _playerPosition = state.position;
  }

  @override
  void onRemove() {
    super.onRemove();
  }
}
