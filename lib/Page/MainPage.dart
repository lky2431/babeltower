import 'package:babeltower/Page/BuildTowerPage.dart';
import 'package:babeltower/Page/DayPage.dart';
import 'package:babeltower/Page/FieldGamePage.dart';
import 'package:babeltower/Page/IntroductionPage.dart';
import 'package:babeltower/Page/ShopPage.dart';
import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cover/CoverPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state) {
      switch (state.stage) {
        case GameStage.cover:
          return CoverPage();
        case GameStage.field:
          return FieldGamePage();
        case GameStage.introduction:
          return IntroductionPage();
        case GameStage.tower:
          return BuildTowerPage();
        case GameStage.day:
          return DayPage();
        case GameStage.shop:
          return ShopPage();
        default:
          return Container();
      }
    });
  }
}
