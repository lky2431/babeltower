import 'package:freezed_annotation/freezed_annotation.dart';

import '../bloc/global/global_bloc.dart';
part 'GameContent.freezed.dart';

enum Difficulty { simple, real, tough }

@freezed
class GameContent with _$GameContent {
  const factory GameContent({
    String? name,
    Difficulty? difficulty,
    @Default({GameStage.field:false, GameStage.tower:false, GameStage.shop:false}) Map<GameStage, bool> hintShown
  }) = _GameContent;
}