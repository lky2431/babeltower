import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../model/GameContent.dart';
import '../../model/Goods.dart';
import '../../repo/HiveRepo.dart';

part 'global_event.dart';
part 'global_state.dart';
part 'global_bloc.freezed.dart';
part 'global_bloc.g.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  saveGame() {
    GameContent game = state.gameContent!;
    hive.saveGame(game.savePosition!, game);
  }

  GlobalBloc({required this.hive}) : super(const GlobalState()) {
    on<_Difficulty>((event, emit) {
      emit(state.copyWith(
          gameContent:
              state.gameContent!.copyWith(difficulty: event.difficulty)));
    });
    on<_Name>((event, emit) {
      emit(state.copyWith(gameContent: GameContent(name: event.name)));
    });
    on<_ChangeStage>((event, emit) {
      if (event.stage == GameStage.tower ||
          event.stage == GameStage.shop ||
          event.stage == GameStage.ending ||
          event.stage == GameStage.day) {
        emit(state.copyWith(
            stage: event.stage,
            gameContent: state.gameContent!.copyWith(stage: event.stage)));
        saveGame();
      } else {
        emit(state.copyWith(stage: event.stage));
      }
    });
    on<_UpdateBlock>((event, emit) {
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(blocks: event.blocks)));
    });
    on<_UpdateTower>((event, emit) {
      emit(state.copyWith(
          gameContent:
              state.gameContent!.copyWith(builtTower: event.towerbuilt)));
    });
    on<_AddBlock>((event, emit) {
      Map<int, int> original = Map.from(state.gameContent!.blocks);
      for (int i in event.blocks.keys) {
        original[i] = (original[i] ?? 0) + event.blocks[i]!;
      }
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(blocks: original)));
    });
    on<_DayPass>((event, emit) {
      emit(state.copyWith(
          stage: GameStage.day,
          gameContent:
              state.gameContent!.copyWith(day: state.gameContent!.day + 1)));
      saveGame();
    });
    on<_setSave>((event, emit) {
      emit(state.copyWith(
          stage: GameStage.introduction,
          gameContent:
              state.gameContent!.copyWith(savePosition: event.position)));
      saveGame();
    });
    on<_UpdateMoney>((event, emit) {
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(money: event.money)));
    });
    on<_Purchase>((event, emit) {
      Map<allGoods, bool> purchased = Map.from(state.gameContent!.goods);
      purchased[event.good.goods] = true;
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(
        goods: purchased,
        money: state.gameContent!.money - event.good.price,
      )));
      saveGame();
    });
    on<_Quit>((event, emit) {
      emit(state.copyWith(gameContent: null, stage: GameStage.cover));
    });
    on<_LoadGame>((event, emit) {
      emit(state.copyWith(stage: event.game.stage, gameContent: event.game));
    });
    on<_UpdateHealth>((event, emit) {
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(health: event.health)));
    });
    on<_FinishTutorial>((event, emit) {
      Map<GameStage, bool> tutor = Map.from(state.gameContent!.hintShown);
      tutor[event.stage] = true;
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(hintShown: tutor)));
    });
  }

  final HiveRepo hive;
}
