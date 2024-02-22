part of 'global_bloc.dart';



@freezed
class GlobalEvent with _$GlobalEvent {
  const factory GlobalEvent.started() = _Started;
  const factory GlobalEvent.name(String name)=_Name;
  const factory GlobalEvent.difficulty(Difficulty difficulty)=_Difficulty;
  const factory GlobalEvent.changeStage(GameStage stage)=_ChangeStage;
  const factory GlobalEvent.updateBlock(Map<int, int> blocks) = _UpdateBlock;
  const factory GlobalEvent.updateTower(Map<int, int> towerbuilt)= _UpdateTower;
  const factory GlobalEvent.addBlock(Map<int, int> blocks) = _AddBlock;
  const factory GlobalEvent.dayPass()= _DayPass;
  const factory GlobalEvent.setSavePosition(int position) = _setSave;
  const factory GlobalEvent.updateMoney(double money) = _UpdateMoney;
  const factory GlobalEvent.purchase(Goods good)= _Purchase;
  const factory GlobalEvent.quit()= _Quit;
  const factory GlobalEvent.updateHealth(double health) = _UpdateHealth;
  const factory GlobalEvent.loadGame(GameContent game) = _LoadGame;
  const factory GlobalEvent.finishTutorial(GameStage stage) = _FinishTutorial;
}
