part of 'player_bloc.dart';

@freezed
class PlayerEvent with _$PlayerEvent {
  const factory PlayerEvent.move(Vector2 move) = _Move;
  const factory PlayerEvent.setPosition(Vector2 position) = _SetPosition;
}
