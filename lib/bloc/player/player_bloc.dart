import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'player_event.dart';
part 'player_state.dart';
part 'player_bloc.freezed.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc(this.initialState) : super(initialState) {
    on<_Move>(onMove);
    on<_SetPosition>(onSetPosition);
    on<_Damage>(onDamage);
  }

  final PlayerState initialState;

  FutureOr<void> onMove(_Move event, Emitter<PlayerState> emit) {
    emit(state.copyWith(speed: event.move));
  }

  FutureOr<void> onSetPosition(_SetPosition event, Emitter<PlayerState> emit) {
    emit(state.copyWith(position: Vector2.copy(event.position)));
  }

  FutureOr<void> onDamage(_Damage event, Emitter<PlayerState> emit) {
    emit(state.copyWith(health: state.health-event.damage));

  }
}
