import 'package:babeltower/dialog/FieldTutorialDialog.dart';
import 'package:babeltower/dialog/LeaveFieldDialog.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../BabelTowerGame.dart';
import '../Widgets/HealthBarWidget.dart';
import '../bloc/global/global_bloc.dart';
import '../bloc/player/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config.dart';

class FieldGamePage extends StatelessWidget {
  const FieldGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerBloc>(
      create: (context) => PlayerBloc(PlayerState(
          speed: Vector2(0, 0),
          position: Vector2(mapSize * 80 / 2, mapSize * 80 - 250))),
      child: Builder(builder: (context) {
        return GameWidget<BabelTowerGame>(
          game: BabelTowerGame(context.read<PlayerBloc>()),
          overlayBuilderMap: {
            "HealthBar": (context, game) => const HealthBarWidget(),
            "Tutorial": (context, game) => FieldTutorialDialog(game),
            "Leave":(context, game)=>LeaveFieldDialog(game)
          },
          initialActiveOverlays: [
            "HealthBar",
            /*if (!context
                .read<GlobalBloc>()
                .state
                .gameContent!
                .hintShown[GameStage.field]!)
              "Tutorial"*/
          ],
        );
      }),
    );
  }
}