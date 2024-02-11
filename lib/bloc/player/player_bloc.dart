import 'dart:async';

import 'package:babeltower/mixin/Indicatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/BuildingBlock.dart';
import '../../model/PickableItem.dart';
part 'player_event.dart';
part 'player_state.dart';
part 'player_bloc.freezed.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc(this.initialState) : super(initialState) {
    on<_Move>(onMove);
    on<_SetPosition>(onSetPosition);
    on<_Damage>(onDamage);
    on<_Drop>(onDrop);
    on<_Pick>(onPick);

    Map<int, PickableItem> map = {};
    for (int i = 0; i < availableBlocks.length; i++) {
      map[i] = PickableItem.building(
          "block", availableBlocks[i], availableBlocks[i].blocks.length * 2);
    }
    emit(state.copyWith(items: map, weight: 15));
  }

  final PlayerState initialState;

  FutureOr<void> onMove(_Move event, Emitter<PlayerState> emit) {
    emit(state.copyWith(speed: event.move));
  }

  FutureOr<void> onSetPosition(_SetPosition event, Emitter<PlayerState> emit) {
    emit(state.copyWith(position: Vector2.copy(event.position)));
  }

  FutureOr<void> onDamage(_Damage event, Emitter<PlayerState> emit) {
    emit(state.copyWith(health: state.health - event.damage));
  }

  FutureOr<void> onDrop(_Drop event, Emitter<PlayerState> emit) {
    PickableItem item = state.items[event.index]!;
    Map<int, PickableItem> items = Map.from(state.items);
    items.remove(event.index);
    emit(state.copyWith(items: items, weight: state.weight - item.weight));
  }

  FutureOr<void> onPick(_Pick event, Emitter<PlayerState> emit) {
    Map<int, PickableItem> items = Map.from(state.items);
    for (int i = 0; i < 30; i++) {
      if (items[i] == null) {
        items[i] = event.item;
        break;
      }
    }
    emit(
        state.copyWith(items: items, weight: state.weight + event.item.weight));
  }

  bool shouldPick(PickableItem item) {
    if (state.items.keys.length >= 30) {
      return false;
    }
    if (state.weight + item.weight > state.maxWeight) {
      return false;
    }
    return true;
  }
}
