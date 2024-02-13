import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:babeltower/model/BuildingBlock.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tower_event.dart';
part 'tower_state.dart';
part 'tower_bloc.freezed.dart';

class TowerBloc extends Bloc<TowerEvent, TowerState> {
  TowerBloc(this.globalBloc)
      : super(TowerState(
            towerBuilt: globalBloc.state.gameContent!.builtTower,
            blocks: globalBloc.state.gameContent!.blocks)) {
    on<_UpdatePosition>(onUpdate);
    on<_Rotate>(onRotate);
    on<_Accept>(onAccept);
  }

  final GlobalBloc globalBloc;

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

    if (!blocks.containAny([0, 3, 6])) {
      blocks = blocks
          .map((e) => e - 1)
          .toList(); //shift left if the left column is empty
    }
    if (!blocks.containAny([6, 7, 8])) {
      blocks = blocks
          .map((e) => e + 3)
          .toList(); //shift to down if the down row is empty
    }
    int width = 3; // detemine the width of the block
    if (!blocks.containAny([2, 5, 8])) {
      // missing third column
      width = 2;
    }
    if (!blocks.containAny([1, 4, 7])) {
      //missing second column
      width = 1;
    }
    if (column + width > 5) {
      column = 5 - width;
    }

    Map<int, List<int>> _tempValid = {};
    Map<int, List<int>> _tempInValid = {};

    int maxHeight = 0; //determine how high the block will be placed.
    /*for (int i = column; i < column + width; i++) {
      if (state.towerBuilt[i]! > maxHeight) {
        maxHeight = state.towerBuilt[i]!;
        if (!blocks.contains(6 + i - column)) {
          maxHeight = maxHeight - 1;
          if (!blocks.contains(3 + 1 - column)) {
            maxHeight = maxHeight - 1;
          }
        }
      }
    }*/
    do {
      _tempValid = {};
      for (int i = 0; i < 9; i++) {
        if (blocks.contains(i)) {
          _tempValid[column + i % 3] = (_tempValid[column + i % 3] ?? [])
            ..add(maxHeight + 2 - (i / 3).floor());
        }
      }
      maxHeight += 1;

      if (maxHeight > 5) {
        return false;
      }
    } while (isOverlap(_tempValid, column, width, state.towerBuilt));

    Map<int, List<int>> gapMap = {};
    for (int i = 0; i < 5; i++) {
      gapMap[i] = List.generate(state.towerBuilt[i] ?? 0, (index) => index)
        ..addAll(_tempValid[i] ?? []);
      gapMap[i] = gapMap[i]!..sort((a, b) => a - b);
    }
    for (int i = 0; i < 5; i++) {
      int? gap = gapMap[i]!.isConsecutive();

      if (gap != null && _tempValid.containsKey(i)) {
        _tempInValid[i] =
            _tempValid[i]!.where((element) => element >= gap).toList();
        _tempValid[i] =
            _tempValid[i]!.where((element) => element < gap).toList();
        if (_tempValid[i]!.isEmpty) {
          _tempValid.remove(i);
        }
      }
    }
    //print("$_tempValid $_tempInValid");
    emit(state.copyWith(valid: _tempValid, notvalid: _tempInValid));
  }

  bool isOverlap(Map<int, List<int>> _tempValid, int column, int width,
      Map<int, int> towerBuilt) {
    for (int i = column; i < column + width; i++) {
      if (_tempValid[i]!.reduce(min) < towerBuilt[i]!) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> onAccept(_Accept event, Emitter<TowerState> emit) {
    if (state.notvalid.isEmpty &&
        state.valid.isNotEmpty &&
        event.index != null) {
      Map<int, int> _tempTower = Map.from(state.towerBuilt);
      for (int key in state.valid.keys) {
        _tempTower[key] = _tempTower[key]! + state.valid[key]!.length;
      }
      Map<int, int> _tempBlock = Map.from(state.blocks);
      _tempBlock[event.index!] = _tempBlock[event.index]! - 1;
      emit(state.copyWith(towerBuilt: _tempTower, blocks: _tempBlock));
    }
    emit(state.copyWith(valid: {}, notvalid: {}));
  }

  @override
  Future<void> close() async {
    super.close();
    globalBloc.add(GlobalEvent.updateBlock(state.blocks));
    globalBloc.add(GlobalEvent.updateTower(state.towerBuilt));
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

  int? isConsecutive() {
    if (isEmpty) {
      return null;
    }
    if (this[0] != 0) {
      return this[0] - 1;
    }
    for (int j = 0; j < length - 1; j++) {
      if (this[j + 1] - this[j] != 1) {
        return j + 1;
      }
    }
    return null;
  }
}
