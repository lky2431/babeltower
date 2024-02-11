part of 'player_bloc.dart';

@freezed
class PlayerEvent with _$PlayerEvent {
  const factory PlayerEvent.move(Vector2 move) = _Move;
  const factory PlayerEvent.setPosition(Vector2 position) = _SetPosition;
  const factory PlayerEvent.damage(double damage)= _Damage;
  const factory PlayerEvent.drop(int index) =_Drop;
  const factory PlayerEvent.pick(PickableItem item) = _Pick;
}
