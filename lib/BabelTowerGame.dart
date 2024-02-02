import 'package:babeltower/Components/CustomCamera.dart';
import 'package:babeltower/Components/PlayerComponent.dart';
import 'package:babeltower/Components/TileComponent.dart';
import 'package:babeltower/Components/TileGenerationComponent.dart';
import 'package:babeltower/bloc/player_bloc.dart';
import 'package:babeltower/config.dart';
import 'package:babeltower/tool/mapGenerator.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';
import 'package:flame_bloc/flame_bloc.dart';

class BabelTowerGame extends FlameGame
    with HasKeyboardHandlerComponents, RiverpodGameMixin {
  BabelTowerGame();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    PlayerComponent player = PlayerComponent();

    camera.setBounds(Rectangle.fromLTRB(size.x / 2, size.y / 2,
        mapSize * 80.0 - size.x / 2, mapSize * 80.0 - size.y / 2));
    world.add(FlameBlocProvider<PlayerBloc, PlayerState>(
        create: () => PlayerBloc(PlayerState(
            speed: Vector2(0, 0),
            position: Vector2(mapSize * 80 / 2, mapSize * 80 - 100))),
        children: [player, TileGenerationComponent()]));
  }

  @override
  Color backgroundColor() => Colors.redAccent.shade100;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    print(size);
  }

  @override
  bool get debugMode => false;
}
