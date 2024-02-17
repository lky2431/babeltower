import 'package:babeltower/Page/Cover/CoverDifficultyPage.dart';
import 'package:babeltower/Page/Cover/CoverLoadPage.dart';
import 'package:babeltower/Page/Cover/CoverMainPage.dart';
import 'package:babeltower/Page/Cover/CoverSavePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global/global_bloc.dart';
import 'CoverNamePage.dart';

enum _CoverStage { game, name, difficulty, save, load }

class CoverPage extends StatefulWidget {
  const CoverPage({super.key});

  @override
  State<CoverPage> createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {
  _CoverStage stage = _CoverStage.game;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {},
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/cover.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox.expand(
          child: _buildPage(),
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (stage) {
      case _CoverStage.game:
        return CoverMainPage(
          onNewGame: () {
            setState(() {
              stage = _CoverStage.name;
            });
          },
          onLoadGame: () {
            setState(() {
              stage = _CoverStage.load;
            });
          },
        );
      case _CoverStage.load:
        return CoverLoadPage(onBack: () {
          setState(() {
            stage = _CoverStage.game;
          });
        });
      case _CoverStage.name:
        return CoverNamePage(
          onConfirm: () {
            setState(() {
              stage = _CoverStage.difficulty;
            });
          },
          onBack: () {
            setState(() {
              stage = _CoverStage.game;
            });
          },
        );
      case _CoverStage.difficulty:
        return CoverDifficultyPage(
          onConfirm: () {
            setState(() {
              stage = _CoverStage.save;
            });
          },
        );
      case _CoverStage.save:
        return CoverSavePage();
      default:
        return Container();
    }
  }
}
