import 'dart:async';
import 'dart:math';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/mixin/Indicatable.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import '../tool/cVectors.dart';

class IndicatorManager extends Component with HasGameRef {
  IndicatorManager({required this.components});
  List<Indicatable> components;
  Map<GlobalKey, IndicatorComponent> records = {};

  int iteration = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (iteration >= 10) {
      for (Indicatable component in components) {
        bool active = component.isActive();
        if (!active && !records.containsKey(component.globalKey)) {
          IndicatorComponent indicator = IndicatorComponent(component);
          game.world.add(indicator);
          records[component.globalKey] = indicator;
        } else if (active && records.containsKey(component.globalKey)) {
          game.world.remove(records[component.globalKey]!);
          records.remove(component.globalKey);
        }
      }
      iteration = 0;
    }
    iteration += 1;
  }

  void removeComponent(GlobalKey key) {
    components =
        components.where((element) => element.globalKey != key).toList();
  }
}

class IndicatorComponent extends SpriteComponent
    with HasGameRef<BabelTowerGame> {
  IndicatorComponent(this.source);

  final Indicatable source;
  late double diagonalAngle;
  late Vector2 gameSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('arrow.png', srcSize: Vector2.all(64));
    anchor = Anchor.center;
    size = v128;
    add(await source.indicatorSprite());
  }

  @override
  void onMount() {
    super.onMount();
    diagonalAngle = atan(gameRef.size.x / gameRef.size.y);
    gameSize = gameRef.size;
  }

  @override
  void update(double dt) {
    super.update(dt);
    double sourceAngle;
    double sourceX = source.position.x;
    double sourceY = source.position.y;
    double camX = camPosition.x;
    double camY = camPosition.y;
    if (sourceX >= camX && sourceY <= camY) {
      sourceAngle = atan((sourceX - camX) / (camY - sourceY));
    } else if (sourceX >= camX && sourceY > camY) {
      sourceAngle = pi - atan((sourceX - camX) / (sourceY - camY));
    } else if (sourceX < camX && sourceY > camY) {
      sourceAngle = pi - atan((sourceX - camX) / (sourceY - camY));
    } else {
      sourceAngle = 2 * pi - atan((sourceX - camX) / (sourceY - camY));
    }
    if (sourceAngle > 2 * pi) {
      sourceAngle = sourceAngle - 2 * pi;
    }
    if (sourceAngle <= 0) {
      sourceAngle = sourceAngle + 2 * pi;
    }
    if (sourceAngle <= diagonalAngle || sourceAngle >= 2 * pi - diagonalAngle) {
      position = camPosition +
          Vector2(
              (gameSize.y / 2 + 32) * tan(sourceAngle), -gameSize.y / 2 + 32);
    } else if (sourceAngle > diagonalAngle &&
        sourceAngle <= pi - diagonalAngle) {
      position = camPosition +
          Vector2(
              gameSize.x / 2 - 32, -(gameSize.x / 2 - 32) / tan(sourceAngle));
    } else if (sourceAngle > pi - diagonalAngle &&
        sourceAngle <= pi + diagonalAngle) {
      position = camPosition +
          Vector2(
              -(gameSize.y / 2 - 32) * tan(sourceAngle), gameSize.y / 2 - 32);
    } else {
      position = camPosition +
          Vector2(
              -gameSize.x / 2 + 32, (gameSize.x / 2 - 32) / tan(sourceAngle));
    }
    angle = sourceAngle;

    /*print(
        "${sourceX - camX} ${sourceY - camY} ${sourceAngle} ${diagonalAngle} ${position - camPosition}");*/
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    diagonalAngle = atan(size.x / size.y);
    gameSize = size;
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;
}
