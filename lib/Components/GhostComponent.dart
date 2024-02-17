import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../tool/cVectors.dart';
import 'PlayerComponent.dart';

class GhostComponent extends SpriteComponent
    with
        CollisionCallbacks,
        FlameBlocReader<GameBloc, GameState>,
        HasGameRef<BabelTowerGame> {
  GhostComponent(this.speed, this._position);

  Vector2 speed;
  Vector2 _position;
  bool attacking = false;
  int indexToCheck = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ghost.png');
    size = v128;
    add(RectangleHitbox(size: v96, position: Vector2.all(12) * vratio));
    position = _position;
    if (speed.x > 0) {
      flipHorizontallyAroundCenter();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    speed.y = speed.y + 400 * dt * vratio;
    position += speed * dt;
    if (indexToCheck > 10) {
      if (position.y > camPosition.y + (gameRef.size).y * 2 / 3) {
        removeFromParent();
      }
      indexToCheck = 0;
    }
    indexToCheck += 1;
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;

  @override
  void onRemove() {}

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is PlayerComponent) {
      if (!attacking) {
        attacking = true;
        bloc.add(const GameEvent.damage(0.01));
        Future.delayed(Duration(seconds: 1), () {
          attacking = false;
        });
      }
    }
  }

  @override
  bool get debugMode => false;
}
