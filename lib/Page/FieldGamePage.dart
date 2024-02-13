import 'package:babeltower/Page/DayPage.dart';
import 'package:babeltower/dialog/BagDialog.dart';
import 'package:babeltower/dialog/CantPickDialog.dart';
import 'package:babeltower/dialog/FieldTutorialDialog.dart';
import 'package:babeltower/dialog/LeaveFieldDialog.dart';
import 'package:babeltower/dialog/SummaryDialog.dart';
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
            "HealthBar": (context, game) => HealthBarWidget(game),
            "Tutorial": (context, game) => FieldTutorialDialog(game),
            "Leave": (context, game) => LeaveFieldDialog(game),
            "Bag": (context, game) => BagDialog(game),
            "Overload": (context, game) => CantPickDialog(true, game: game),
            "Overitem": (context, game) => CantPickDialog(false, game: game),
            "Summary": (context, game) => SummaryDialog(),

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
