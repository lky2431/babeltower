part of 'tower_bloc.dart';

@freezed
class TowerEvent with _$TowerEvent {
  const factory TowerEvent.updatePosition(int column, int index) = _UpdatePosition;
  const factory TowerEvent.rotate() = _Rotate;
  const factory TowerEvent.accept(int? index) = _Accept;

}
