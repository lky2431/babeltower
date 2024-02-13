part of 'global_bloc.dart';

enum GameStage { cover, field, introduction, tower, shop, day }

@freezed
class GlobalState with _$GlobalState {
  const factory GlobalState(
      {@Default(GameStage.cover) GameStage stage,
      GameContent? gameContent}) = _GlobalState;
}
