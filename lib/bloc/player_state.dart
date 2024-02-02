part of 'player_bloc.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    required Vector2 speed,
    @Default(false) bool moving,
    required Vector2 position
  }) = _PlayerState;
}
