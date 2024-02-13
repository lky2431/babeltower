import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/GameContent.dart';

part 'global_event.dart';
part 'global_state.dart';
part 'global_bloc.freezed.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState()) {
    emit(state.copyWith(
        stage: GameStage.day,
        gameContent: GameContent(
            builtTower: {0: 1, 1: 2, 2: 0, 3: 1, 4: 3},
            blocks: {0: 1, 1: 3, 2: 2, 3: 2, 4: 1, 5: 1, 6: 1})));
    on<_Difficulty>((event, emit) {
      emit(state.copyWith(
          stage: GameStage.introduction,
          gameContent:
              state.gameContent!.copyWith(difficulty: event.difficulty)));
    });
    on<_Name>((event, emit) {
      emit(state.copyWith(gameContent: GameContent(name: event.name)));
    });
    on<_ChangeStage>((event, emit) {
      emit(state.copyWith(stage: event.stage));
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
        original[i] = original[i]! + event.blocks[i]!;
      }
      emit(state.copyWith(
          gameContent: state.gameContent!.copyWith(blocks: original)));
    });
  }
}
