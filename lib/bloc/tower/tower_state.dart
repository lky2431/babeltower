part of 'tower_bloc.dart';

@freezed
class TowerState with _$TowerState {
  const factory TowerState({
    Offset? offset,
    @Default(0) int rotation,
    required Map<int, int> towerBuilt,
    required Map<int, int> blocks,
    @Default({}) Map<int, List<int>> valid,
    @Default({}) Map<int, List<int>> notvalid,
    @Default(false) bool isFinish,
  }) = _Initial;
}
