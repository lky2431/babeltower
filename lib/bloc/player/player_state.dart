part of 'player_bloc.dart';

@freezed
class GameState with _$PlayerState {
  const factory GameState({
    required Vector2 speed,
    @Default(false) bool moving,
    required Vector2 position,
    required double health,
    @Default({}) Map<int, PickableItem> items,
    @Default(0) double weight,
    @Default(50) double maxWeight,
    required Difficulty difficulty,
    required Map<allGoods, bool> goods,
  }) = _PlayerState;
}
