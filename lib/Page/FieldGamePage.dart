import 'package:babeltower/dialog/BagDialog.dart';
import 'package:babeltower/dialog/CantPickDialog.dart';
import 'package:babeltower/dialog/DeadDialog.dart';
import 'package:babeltower/dialog/FieldTutorialDialog.dart';
import 'package:babeltower/dialog/LeaveFieldDialog.dart';
import 'package:babeltower/dialog/SummaryDialog.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../BabelTowerGame.dart';
import '../Widgets/HealthBarWidget.dart';
import '../bloc/global/global_bloc.dart';
import '../bloc/player/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config.dart';

class FieldGamePage extends StatefulWidget {
  const FieldGamePage({super.key});

  @override
  State<FieldGamePage> createState() => _FieldGamePageState();
}

class _FieldGamePageState extends State<FieldGamePage> {
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery.of(context).size.shortestSide;
    return BlocProvider<GameBloc>(
      create: (context) => GameBloc(GameState(
          health: context.read<GlobalBloc>().state.gameContent!.health,
          speed: Vector2(0, 0),
          position:
              Vector2(mapSize * tileSize / 8 / 2, mapSize * tileSize / 8 - 250),
          difficulty:
              context.read<GlobalBloc>().state.gameContent!.difficulty ??
                  Difficulty.real,
          goods: context.read<GlobalBloc>().state.gameContent!.goods)),
      child: _Game(),
    );
  }
}

class _Game extends StatefulWidget {
  const _Game({super.key});

  @override
  State<_Game> createState() => _GameState();
}

class _GameState extends State<_Game> {
  late BabelTowerGame game;

  @override
  void initState() {
    super.initState();
    game = BabelTowerGame(context.read<GameBloc>());
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget<BabelTowerGame>(
      game: game,
      overlayBuilderMap: {
        "HealthBar": (context, game) => HealthBarWidget(game),
        "Tutorial": (context, game) => FieldTutorialDialog(game),
        "Leave": (context, game) => LeaveFieldDialog(game),
        "Bag": (context, game) => BagDialog(game),
        "Overload": (context, game) => CantPickDialog(true, game: game),
        "Overitem": (context, game) => CantPickDialog(false, game: game),
        "Summary": (context, game) => SummaryDialog(),
        "Dead": (context, game) => DeadDialog()
      },
      initialActiveOverlays: [
        "HealthBar",
        if (!context
            .read<GlobalBloc>()
            .state
            .gameContent!
            .hintShown[GameStage.field]!)
          "Tutorial"
      ],
    );
  }
}
