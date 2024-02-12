import 'dart:async';
import 'dart:ui';

import 'package:babeltower/model/BuildingBlock.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tower_event.dart';
part 'tower_state.dart';
part 'tower_bloc.freezed.dart';

class TowerBloc extends Bloc<TowerEvent, TowerState> {
  TowerBloc(this.builtTower) : super(TowerState(towerBuilt: builtTower)) {
    on<_UpdatePosition>(onUpdate);
    on<_Rotate>(onRotate);
    on<_Leave>(onLeave);
  }

  final Map<int, int> builtTower;

  FutureOr<void> onRotate(_Rotate event, Emitter<TowerState> emit) {
    emit(
        state.copyWith(rotation: state.rotation == 3 ? 0 : state.rotation + 1));
  }

  FutureOr<void> onUpdate(_UpdatePosition event, Emitter<TowerState> emit) {
    int column = event.column;
    if (column < 0) {
      column = 0;
    }
    BuildingBlock block = availableBlocks[event.index]!;
    List<int> blocks = block.rotate(state.rotation);
    int width = 3; // detemine the width of the block
    if (!blocks.containAny([2, 5, 8])) {
      // missing third column
      width = 2;
    }
    if (!blocks.containAny([1, 4, 7])) {
      //missing second column
      width = 1;
    }
    if(column+width>5){
      column=5-width;
    }


    Map<int, List<int>> _temp = {};
    if (!blocks.containAny([0, 3, 6])) {
      blocks = blocks
          .map((e) => e - 1)
          .toList(); //shift left if the left column is empty
    }
    if (!blocks.containAny([7, 8, 9])) {
      blocks = blocks
          .map((e) => e + 3)
          .toList(); //shift to down if the down row is empty
    }

    int maxHeight = 0; //determine how high the block will be placed.
    for (int i = column; i < column + width; i++) {
      if (state.towerBuilt[i]! > maxHeight) {
        maxHeight = state.towerBuilt[i]!;
      }
    }
    for (int i = 0; i < 9; i++) {
      if (blocks.contains(i)) {
        _temp[column + i % 3] = (_temp[column + i % 3] ?? [])
          ..add(maxHeight + 2 - (i / 3).floor());
      }
    }
    emit(state.copyWith(valid: _temp));
    /*if(blocks.contains(6)){
      _temp[column]=(_temp[column]??[])..add(maxHeight+1);
    }
    if(blocks.contains(7)){
      _temp[column+1]=(_temp[column+1]??[])..add(maxHeight+1);
    }
    if(blocks.contains(3)){
      _temp[column] = (_temp[column]??[])..add(maxHeight+2);
    }
    if(blocks.contains(0)){
      _temp[column] = (_temp[column]??[])..add(maxHeight+3);
    }*/
  }

  FutureOr<void> onLeave(_Leave event, Emitter<TowerState> emit) {
    emit(state.copyWith(valid: {}));
  }
}

extension on List<int> {
  bool containAny(List<int> elements) {
    for (int i in elements) {
      if (contains(i)) {
        return true;
      }
    }
    return false;
  }
}
