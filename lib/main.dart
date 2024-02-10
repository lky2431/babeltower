import 'package:babeltower/Widgets/HealthBarWidget.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'BabelTowerGame.dart';
import 'Page/MainPage.dart';
import 'bloc/global/global_bloc.dart';
import 'bloc/player/player_bloc.dart';
import 'config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
      colorSchemeSeed: Colors.brown,
      brightness: Brightness.dark,
      fontFamily: "Pixel",
      textTheme: TextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.white)
      )
    ),
    home: BlocProvider(
        create: (BuildContext context) => GlobalBloc(),
        child: Scaffold(body: MainPage())),
  ));
}
