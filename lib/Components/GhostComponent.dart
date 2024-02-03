import 'package:babeltower/bloc/player_bloc.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../tool/cVectors.dart';
import 'PlayerComponent.dart';

class GhostComponent extends SpriteComponent
    with CollisionCallbacks, FlameBlocReader<PlayerBloc, PlayerState> {
  GhostComponent(this.speed, this._position);

  Vector2 speed;
  Vector2 _position;
  bool attacking = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ghost.png');
    size = v128;
    add(RectangleHitbox(size: v96,position: Vector2.all(12)));
    position = _position;
    if (speed.x > 0) {
      flipHorizontallyAroundCenter();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    speed.y = speed.y + 400 * dt;
    position += speed * dt;
  }

  @override
  void onRemove() {}

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is PlayerComponent) {
      if (!attacking) {
        attacking = true;
        bloc.add(const PlayerEvent.damage(0.01));
        Future.delayed(Duration(seconds: 1), () {
          attacking = false;
        });
      }
    }
  }

  @override
  
  bool get debugMode => false;
}
