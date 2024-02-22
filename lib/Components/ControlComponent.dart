
import 'package:babeltower/BabelTowerGame.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/player/player_bloc.dart';

import '../tool/cVectors.dart';

class ControlComponent extends PositionComponent
    with
        DragCallbacks,
        HasGameRef<BabelTowerGame>,
        FlameBlocReader<GameBloc, GameState> {
  ControlComponent();

  CircleComponent? baseCircle;
  CircleComponent? smallCircle;
  Vector2? initialPosition;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = gameRef.size;
    anchor = Anchor.center;
    add(RectangleComponent(
        size: size, paint: Paint()..color = Colors.transparent));
    priority = 1000;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = gameRef.camera.viewfinder.position;
  }

  @override
  void onGameResize(Vector2 newsize) {
    super.onGameResize(newsize);
    size = newsize;
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    initialPosition = event.canvasPosition;
    baseCircle = CircleComponent(
        radius: v64.x,
        position: initialPosition,
        anchor: Anchor.center,
        paint: Paint()..color = Colors.white54);
    smallCircle = CircleComponent(
        radius: v32.x,
        position: initialPosition,
        anchor: Anchor.center,
        paint: Paint()..color = Colors.white60);
    add(baseCircle!);
    add(smallCircle!);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    Vector2 newPosition = event.canvasEndPosition;
    if (initialPosition != null) {
      if (newPosition.distanceTo(initialPosition!) > v196.x) {
        stop();

      }
      if (newPosition.distanceTo(initialPosition!) > v48.x) {
        newPosition = initialPosition! +
            ((newPosition - initialPosition!).normalized() * v48.x);
      }
      bloc.add(GameEvent.move((newPosition - initialPosition!).normalized()));
    }
    smallCircle?.position = newPosition;
  }

  void stop() {
    baseCircle?.removeFromParent();
    smallCircle?.removeFromParent();
    bloc.add(GameEvent.move(Vector2.zero()));
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    stop();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    stop();
  }
}
