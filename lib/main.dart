import 'package:babeltower/Widgets/HealthBarWidget.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'BabelTowerGame.dart';
import 'bloc/player_bloc.dart';
import 'config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(
    BlocProvider<PlayerBloc>(
      create: (context) => PlayerBloc(PlayerState(
          speed: Vector2(0, 0),

          position: Vector2(mapSize * 80 / 2, mapSize * 80 - 100))),
      child: Builder(builder: (context) {
        return GameWidget<BabelTowerGame>(
          game: BabelTowerGame(context.read<PlayerBloc>()),
          overlayBuilderMap: {
            "HealthBar": (context, game) => const HealthBarWidget()
          },
          initialActiveOverlays: ["HealthBar"],
        );
      }),
    ),
  );
}
