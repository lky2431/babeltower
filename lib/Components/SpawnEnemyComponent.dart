import 'dart:math';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/EmptyComponent.dart';
import 'package:babeltower/Components/ExplosionComponent.dart';
import 'package:babeltower/Components/GhostComponent.dart';
import 'package:babeltower/Components/MosquitoComponent.dart';
import 'package:babeltower/Components/ZombieComponent.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:babeltower/tool/cVectors.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

class SpawnEnemyComponent extends Component
    with HasGameRef<BabelTowerGame>, FlameBlocReader<GameBloc, GameState> {
  SpawnEnemyComponent();

  late Vector2 _size;
  int zombieNumber = 0;

  late final Difficulty difficulty;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    difficulty = bloc.state.difficulty;
    SpawnComponent zombieSpawn = SpawnComponent(
        factory: (int amount) {
          if (zombieNumber >
              switch (difficulty) {
                Difficulty.simple => 10,
                Difficulty.real => 20,
                Difficulty.tough => 40,
              }) {
            return EmptyComponent();
          }
          zombieNumber += 1;
          return ZombieComponent(zombiePosition(), onDestroyed: () {
            zombieNumber -= 1;
          });
        },
        period: switch (difficulty) {
          Difficulty.simple => 5,
          Difficulty.real => 2,
          Difficulty.tough => 1,
        });

    SpawnComponent ghostSpawn = SpawnComponent(
        factory: (int amount) {
          (Vector2, Vector2, double) d = ghostDimension();
          return GhostComponent(d.$1, d.$2, acceleration: d.$3);
        },
        period: switch (difficulty) {
          Difficulty.simple => 2,
          Difficulty.real => 1,
          Difficulty.tough => 0.5,
        });
    SpawnComponent mosquitoSpawn = SpawnComponent(
        factory: (int amount) {
          (Vector2, Vector2) d = mosquitoDimension();
          return MosquitoGroupComponent(initPosition: d.$1, speed: d.$2);
        },
        period: switch (difficulty) {
          Difficulty.simple => 6,
          Difficulty.real => 3,
          Difficulty.tough => 1.5,
        });
    SpawnComponent explodeSpawn = SpawnComponent.periodRange(
        factory: (int amount) {
          return ExplosionComponent(initPosition: explodeDimension());
        },
        minPeriod: switch (difficulty) {
          Difficulty.simple => 2.5,
          Difficulty.real => 1.2,
          Difficulty.tough => 0.7,
        },
        maxPeriod: switch (difficulty) {
          Difficulty.simple => 5,
          Difficulty.real => 2.5,
          Difficulty.tough => 1.2,
        });
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

  (Vector2, Vector2, double) ghostDimension() {
    double acceleration = _size.y / 4;
    double rx = Random().nextDouble() - 0.5;
    Vector2 shiftVector = Vector2(rx * _size.x, _size.y / 2);
    return (
      Vector2(rx * 500 * vratio,
          -2 * acceleration * (0.9 + Random().nextDouble() * 0.5)),
      camPosition + shiftVector,
      acceleration
    );
  }

  (Vector2, Vector2) mosquitoDimension() {
    Vector2 shiftVector = Random().nextBool()
        ? Vector2(Random().nextBool() ? _size.x / 2 + 100 : -_size.x / 2 - 100,
            (Random().nextDouble() - 0.5) * _size.y)
        : Vector2((Random().nextDouble() - 0.5) * _size.x,
            Random().nextBool() ? _size.y / 2 + 100 : -_size.y / 2 - 100);

    return (
      camPosition + shiftVector,
      -shiftVector
        ..rotate((Random().nextDouble() - 0.5) * 20 / 180 * pi)
    );
  }

  Vector2 explodeDimension() {
    Vector2 shiftVector = Vector2((Random().nextDouble() - 0.5) * _size.x,
            (Random().nextDouble() - 0.5) * _size.y) *
        0.8;
    return camPosition + shiftVector;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _size = size;
  }
}
