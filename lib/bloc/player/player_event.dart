part of 'player_bloc.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.move(Vector2 move) = _Move;
  const factory GameEvent.setPosition(Vector2 position) = _SetPosition;
  const factory GameEvent.damage(double damage)= _Damage;
  const factory GameEvent.drop(int index) =_Drop;
  const factory GameEvent.pick(PickableItem item) = _Pick;
}
