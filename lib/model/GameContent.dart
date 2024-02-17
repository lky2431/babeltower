import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../bloc/global/global_bloc.dart';

import 'Goods.dart';
part 'GameContent.g.dart';
part 'GameContent.freezed.dart';

@HiveType(typeId: 2)
enum Difficulty {
  @HiveField(0)
  simple,
  @HiveField(1)
  real,
  @HiveField(2)
  tough
}

@freezed
class GameContent extends HiveObject with _$GameContent {
  GameContent._();

  @HiveType(typeId: 1)
  factory GameContent({
    @HiveField(0) String? name,
    @HiveField(1) Difficulty? difficulty,
    @HiveField(2)
    @Default(
        {GameStage.field: false, GameStage.tower: false, GameStage.shop: false})
    Map<GameStage, bool> hintShown,
    @HiveField(3)
    @Default({0: 0, 1: 0, 2: 0, 3: 0, 4: 0})
    Map<int, int> builtTower,
    @HiveField(4)
    @Default({0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0})
    Map<int, int> blocks,
    @HiveField(5) @Default(GameStage.introduction) GameStage stage,
    @HiveField(6) @Default(1) int day,
    @HiveField(7)
    @Default({
      allGoods.Basket: false,
      allGoods.Jacket: false,
      allGoods.Phone: false,
      allGoods.Shoe: false
    })
    Map<allGoods, bool> goods,
    @HiveField(8) int? savePosition,
    @HiveField(9) @Default(5) double money,
    @HiveField(10) @Default(1.0) double health
  }) = _GameContent;
}
