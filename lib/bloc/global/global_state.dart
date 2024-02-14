part of 'global_bloc.dart';


@HiveType(typeId: 3)
enum GameStage {
  @HiveField(0)
  cover,
  @HiveField(1)
  field,
  @HiveField(2)
  introduction,
  @HiveField(3)
  tower,
  @HiveField(4)
  shop,
  @HiveField(5)
  day
}

@freezed
class GlobalState with _$GlobalState {
  const factory GlobalState(
      {@Default(GameStage.cover) GameStage stage,
      GameContent? gameContent}) = _GlobalState;
}
