import 'dart:math';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/EmptyComponent.dart';
import 'package:babeltower/Components/ExplosionComponent.dart';
import 'package:babeltower/Components/GhostComponent.dart';
import 'package:babeltower/Components/MosquitoComponent.dart';
import 'package:babeltower/Components/ZombieComponent.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/tool/cVectors.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';

class SpawnEnemyComponent extends Component with HasGameRef<BabelTowerGame> {
  SpawnEnemyComponent();

  late Vector2 _size;
  int zombieNumber = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    SpawnComponent zombieSpawn = SpawnComponent(
        factory: (int amount) {
          zombieNumber += 1;
          if (zombieNumber > 20) {
            return EmptyComponent();
          }
          return ZombieComponent(zombiePosition(), onDestroyed: () {
            zombieNumber -= 1;
          });
        },
        period: 2);

    SpawnComponent ghostSpawn = SpawnComponent(
        factory: (int amount) {
          (Vector2, Vector2) d = ghostDimension();
          return GhostComponent(d.$1, d.$2);
        },
        period: 1);
    SpawnComponent mosquitoSpawn = SpawnComponent(
        factory: (int amount) {
          (Vector2, Vector2) d = mosquitoDimension();
          return MosquitoGroupComponent(initPosition: d.$1, speed: d.$2);
        },
        period: 2);
    SpawnComponent explodeSpawn = SpawnComponent.periodRange(
        factory: (int amount) {
          return ExplosionComponent(initPosition: explodeDimension());
        },
        minPeriod: 0.7,
        maxPeriod: 2.5);
    add(zombieSpawn);
    add(ghostSpawn);
    add(mosquitoSpawn);
    add(explodeSpawn);
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;

  Vector2 zombiePosition() {
    Vector2 shiftVector = Random().nextBool()
        ? Vector2(Random().nextBool() ? _size.x / 2 + 100 : -_size.x / 2 - 100,
            (Random().nextDouble() - 0.5) * _size.y)
        : Vector2((Random().nextDouble() - 0.5) * _size.x,
            Random().nextBool() ? _size.y / 2 + 100 : -_size.y / 2 - 100);
    return camPosition + shiftVector;
  }

  (Vector2, Vector2) ghostDimension() {
    double rx = Random().nextDouble() - 0.5;
    Vector2 shiftVector = Vector2(rx * _size.x, _size.y / 2);
    return (
      Vector2(rx * 500, -800 - Random().nextDouble() * 500) * vratio,
      camPosition + shiftVector
    );
  }

  (Vector2, Vector2) mosquitoDimension() {
    Vector2 shiftVector = Random().nextBool()
        ? Vector2(Random().nextBool() ? _size.x / 2 + 100 : -_size.x / 2 - 100,
            (Random().nextDouble() - 0.5) * _size.y)
        : Vector2((Random().nextDouble() - 0.5) * _size.x,
            Random().nextBool() ? _size.y / 2 + 100 : -_size.y / 2 - 100);

    return (camPosition + shiftVector, -shiftVector..rotate((Random().nextDouble()-0.5)*20/180*pi));
  }

  Vector2 explodeDimension() {
    Vector2 shiftVector = Vector2((Random().nextDouble() - 0.5) * _size.x,
        (Random().nextDouble() - 0.5) * _size.y);
    return camPosition + shiftVector;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _size = size;
  }
}
