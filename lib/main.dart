import 'package:flutter/material.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'BabelTowerGame.dart';

void main() async {
  //await FlameInitiate();
  final babelTower = BabelTowerGame();

  runApp(ProviderScope(
    child: RiverpodAwareGameWidget<BabelTowerGame>(
      game: babelTower,
      key: GlobalKey(),
    ),
  ));
}
