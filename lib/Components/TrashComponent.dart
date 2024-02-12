import 'dart:math';
import 'dart:ui';

import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/model/PickableItem.dart';
import 'package:babeltower/model/Trash.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../tool/cVectors.dart';

class TrashComponent extends PositionComponent
    with
        CollisionCallbacks,
        FlameBlocReader<PlayerBloc, PlayerState>,
        HasGameRef {
  TrashComponent({required this.initialPosition});

  late final Trash trash;
  bool picking = false;
  final Vector2 initialPosition;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    trash = availableTrashs[Random().nextInt(availableTrashs.length)];
    size = trash.size;
    add(RectangleHitbox());
    angle = Random().nextDouble() * 2 * pi;
    add(CircleComponent(
      priority: -1,
        radius: size.x/2,
        paint: Paint()..color=Colors.green.withOpacity(0.4)
    ));
    add(SpriteComponent(
      sprite: await Sprite.load('${trash.name}.png', srcSize: Vector2.all(32)),
      size: size,
    ));
    position = initialPosition;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlayerComponent && !picking) {
      picking = true;
      PickableItem item = PickableItem.normal(
          trash.description, trash.name, trash.weight, trash.price);
      String? result = bloc.shouldPick(item);
      if (result == null) {
        bloc.add(PlayerEvent.pick(item));
        removeFromParent();
      } else {
        gameRef.overlays.add(result);
        Future.delayed(Duration(seconds: 3),(){
          picking=false;
        });
      }
    }
  }
}
