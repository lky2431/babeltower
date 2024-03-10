
import 'dart:math';

import 'package:babeltower/Components/BuildingBlockComponent.dart';
import 'package:babeltower/Components/ControlComponent.dart';
import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/Components/SpawnEnemyComponent.dart';

import 'package:babeltower/Components/TileGenerationComponent.dart';
import 'package:babeltower/Components/TrashComponent.dart';

import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:babeltower/config.dart';
import 'package:babeltower/tool/cVectors.dart';

import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'Components/DeadListener.dart';
import 'Components/IndicatorComponent.dart';
import 'Components/PortalComponent.dart';
import 'model/BuildingBlock.dart';

class BabelTowerGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, PanDetector {
  BabelTowerGame(this.playerBloc);
  final GameBloc playerBloc;
  late FlameBlocProvider provider;
  late IndicatorManager indicatorManager;
  late final double tileSize;
  bool initialSize = false;

  @override
  Future<void> onLoad() async {
    getTileSize();
    await super.onLoad();

    PlayerComponent player = PlayerComponent();
    camera.setBounds(Rectangle.fromLTRB(size.x / 2, size.y / 2,
        mapSize * tileSize - size.x / 2, mapSize * tileSize - size.y / 2));
    PortalComponent portal = PortalComponent();
    List<BuildingBlockComponent> blocks = List.generate(
        Random().nextInt(2) + 3,
        (index) => BuildingBlockComponent(
            // gameRef: this,
            index: Random().nextInt(availableBlocks.values.length),
            initialPosition: Vector2(Random().nextDouble() * mapSize * tileSize,
                Random().nextDouble() * mapSize * tileSize)));
    indicatorManager = IndicatorManager(components: [portal, ...blocks]);

    provider = FlameBlocProvider<GameBloc, GameState>.value(children: [
      player,
      TileGenerationComponent(),
      SpawnEnemyComponent(),
      ControlComponent(),
      DeadListener(),
      portal,
      indicatorManager,
      ...blocks,
      ...List.generate(
          40,
          (index) => TrashComponent(
              initialPosition: Vector2(
                  Random().nextDouble() * mapSize * tileSize,
                  Random().nextDouble() * mapSize * tileSize))),
    ], value: playerBloc);
    world.add(provider);
    FlameAudio.bgm.initialize();
    if (!kIsWeb ){
      FlameAudio.bgm.play('traversing.mp3', volume: 0.3);
    }


  }

  @override
  void onDispose() {
    super.onDispose();
    if (!kIsWeb ){
      FlameAudio.bgm.stop();
    }

  }

  @override
  Color backgroundColor() => const Color(0xFF5f4c40);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    Vectors.instance.setRatio(size);
    if (initialSize) {
      camera.setBounds(Rectangle.fromLTRB(size.x / 2, size.y / 2,
          mapSize * tileSize - size.x / 2, mapSize * tileSize - size.y / 2));
    }
  }

  @override
  bool get debugMode => false;

  getTileSize() {
    double shorterSize = size.x;
    if (shorterSize > size.y) {
      shorterSize = size.y;
    }
    tileSize = shorterSize / 8;
    camera.setBounds(Rectangle.fromLTRB(size.x / 2, size.y / 2,
        mapSize * tileSize - size.x / 2, mapSize * tileSize - size.y / 2));
    initialSize = true;
  }
}
