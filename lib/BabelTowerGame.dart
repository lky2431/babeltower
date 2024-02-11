import 'dart:math';

import 'package:babeltower/Components/BuildingBlockComponent.dart';
import 'package:babeltower/Components/ControlComponent.dart';
import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/Components/SpawnEnemyComponent.dart';

import 'package:babeltower/Components/TileGenerationComponent.dart';

import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/config.dart';
import 'package:babeltower/tool/cVectors.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'Components/IndicatorComponent.dart';
import 'Components/PortalComponent.dart';
import 'model/BuildingBlock.dart';

class BabelTowerGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, PanDetector {
  BabelTowerGame(this.playerBloc);
  final PlayerBloc playerBloc;
  late FlameBlocProvider provider;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    PlayerComponent player = PlayerComponent();
    camera.setBounds(Rectangle.fromLTRB(size.x / 2, size.y / 2,
        mapSize * 80.0 - size.x / 2, mapSize * 80.0 - size.y / 2));
    PortalComponent portal = PortalComponent();
    provider = FlameBlocProvider<PlayerBloc, PlayerState>.value(children: [
      player,
      TileGenerationComponent(),
      SpawnEnemyComponent(),
      ControlComponent(),
      portal,
      IndicatorManager(components: [portal]),
      ...List.generate(
          5,
          (index) => BuildingBlockComponent(
              block: availableBlocks[Random().nextInt(availableBlocks.length)],
              initialPosition: Vector2(Random().nextDouble() * mapSize * 80,
              Random().nextDouble() * mapSize * 80)))
    ], value: playerBloc);
    world.add(provider);
  }

  @override
  Color backgroundColor() => const Color(0xFF5f4c40);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    Vectors.instance.setRatio(size);
    camera.setBounds(Rectangle.fromLTRB(size.x / 2, size.y / 2,
        mapSize * 80.0 - size.x / 2, mapSize * 80.0 - size.y / 2));
  }

  @override
  bool get debugMode => false;
}
