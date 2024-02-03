import 'dart:math';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/GhostComponent.dart';
import 'package:babeltower/Components/ZombieComponent.dart';
import 'package:babeltower/bloc/player_bloc.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';

class SpawnEnemyComponent extends Component
    with
        FlameBlocListenable<PlayerBloc, PlayerState>,
        HasGameRef<BabelTowerGame> {
  SpawnEnemyComponent();

  late Vector2 _size;
  late Vector2 _playerPosition;
  int zombieNumber = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    SpawnComponent zombieSpawn = SpawnComponent(
        factory: (int amount) {
          zombieNumber += 1;
          return ZombieComponent(zombiePosition(), onDestroyed: () {
            zombieNumber -= 1;
          });
        },
        period: 2);
    SpawnComponent ghostSpawn = SpawnComponent(
        factory: (int amount) {
          return GhostComponent(ghostDimension().$1, ghostDimension().$2);
        },
        period: 1);
    add(zombieSpawn);
    add(ghostSpawn);
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
      Vector2(rx * 500, -800 - Random().nextDouble() * 500),
      camPosition + shiftVector
    );
  }

  @override
  void onInitialState(PlayerState state) {
    super.onInitialState(state);
    _playerPosition = state.position;
  }

  @override
  void onNewState(PlayerState state) {
    super.onNewState(state);
    _playerPosition = state.position;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _size = size;
  }
}
