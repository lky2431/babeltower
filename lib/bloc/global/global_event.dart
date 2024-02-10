part of 'global_bloc.dart';



@freezed
class GlobalEvent with _$GlobalEvent {
  const factory GlobalEvent.started() = _Started;
  const factory GlobalEvent.name(String name)=_Name;
  const factory GlobalEvent.difficulty(Difficulty difficulty)=_Difficulty;
  const factory GlobalEvent.changeStage(GameStage stage)=_ChangeStage;
}
