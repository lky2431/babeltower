import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/GameContent.dart';

part 'global_event.dart';
part 'global_state.dart';
part 'global_bloc.freezed.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState()) {
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
  }
}
