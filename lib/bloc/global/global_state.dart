part of 'global_bloc.dart';

enum GameStage { cover, field, introduction, tower, shop}

@freezed
class GlobalState with _$GlobalState {
  const factory GlobalState({
    @Default(GameStage.tower) GameStage stage,
    GameContent? gameContent

  }) = _GlobalState;
}
