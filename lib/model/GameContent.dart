import 'package:freezed_annotation/freezed_annotation.dart';

import '../bloc/global/global_bloc.dart';
import 'BuildingBlock.dart';
import 'Goods.dart';
part 'GameContent.freezed.dart';

enum Difficulty { simple, real, tough }

@freezed
class GameContent with _$GameContent {
  const factory GameContent({
    String? name,
    Difficulty? difficulty,
    @Default(
        {GameStage.field: false, GameStage.tower: false, GameStage.shop: false})
    Map<GameStage, bool> hintShown,
    @Default({0: 0, 1: 0, 2: 0, 3: 0, 4: 0}) Map<int, int> builtTower,
    @Default({0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0}) Map<int, int> blocks,
    @Default(GameStage.day) GameStage stage,
    @Default(1) int day,
    @Default({
      allGoods.Basket: false,
      allGoods.Jacket: false,
      allGoods.Phone: false,
      allGoods.Shoe: false
    })
    Map<allGoods, bool> goods,
  }) = _GameContent;
}
