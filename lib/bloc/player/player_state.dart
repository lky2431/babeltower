part of 'player_bloc.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    required Vector2 speed,
    @Default(false) bool moving,
    required Vector2 position,
    @Default(1) double health,
    @Default({}) Map<int, PickableItem> items,
    @Default(0) double weight,
    @Default(50) double maxWeight,
    required Difficulty difficulty,
    required Map<allGoods, bool> goods,
  }) = _PlayerState;
}
