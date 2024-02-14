// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Vector2 move) move,
    required TResult Function(Vector2 position) setPosition,
    required TResult Function(double damage) damage,
    required TResult Function(int index) drop,
    required TResult Function(PickableItem item) pick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Vector2 move)? move,
    TResult? Function(Vector2 position)? setPosition,
    TResult? Function(double damage)? damage,
    TResult? Function(int index)? drop,
    TResult? Function(PickableItem item)? pick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Vector2 move)? move,
    TResult Function(Vector2 position)? setPosition,
    TResult Function(double damage)? damage,
    TResult Function(int index)? drop,
    TResult Function(PickableItem item)? pick,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Move value) move,
    required TResult Function(_SetPosition value) setPosition,
    required TResult Function(_Damage value) damage,
    required TResult Function(_Drop value) drop,
    required TResult Function(_Pick value) pick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Move value)? move,
    TResult? Function(_SetPosition value)? setPosition,
    TResult? Function(_Damage value)? damage,
    TResult? Function(_Drop value)? drop,
    TResult? Function(_Pick value)? pick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Move value)? move,
    TResult Function(_SetPosition value)? setPosition,
    TResult Function(_Damage value)? damage,
    TResult Function(_Drop value)? drop,
    TResult Function(_Pick value)? pick,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerEventCopyWith<$Res> {
  factory $PlayerEventCopyWith(
          PlayerEvent value, $Res Function(PlayerEvent) then) =
      _$PlayerEventCopyWithImpl<$Res, PlayerEvent>;
}

/// @nodoc
class _$PlayerEventCopyWithImpl<$Res, $Val extends PlayerEvent>
    implements $PlayerEventCopyWith<$Res> {
  _$PlayerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MoveImplCopyWith<$Res> {
  factory _$$MoveImplCopyWith(
          _$MoveImpl value, $Res Function(_$MoveImpl) then) =
      __$$MoveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Vector2 move});
}

/// @nodoc
class __$$MoveImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$MoveImpl>
    implements _$$MoveImplCopyWith<$Res> {
  __$$MoveImplCopyWithImpl(_$MoveImpl _value, $Res Function(_$MoveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? move = null,
  }) {
    return _then(_$MoveImpl(
      null == move
          ? _value.move
          : move // ignore: cast_nullable_to_non_nullable
              as Vector2,
    ));
  }
}

/// @nodoc

class _$MoveImpl implements _Move {
  const _$MoveImpl(this.move);

  @override
  final Vector2 move;

  @override
  String toString() {
    return 'PlayerEvent.move(move: $move)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoveImpl &&
            (identical(other.move, move) || other.move == move));
  }

  @override
  int get hashCode => Object.hash(runtimeType, move);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoveImplCopyWith<_$MoveImpl> get copyWith =>
      __$$MoveImplCopyWithImpl<_$MoveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Vector2 move) move,
    required TResult Function(Vector2 position) setPosition,
    required TResult Function(double damage) damage,
    required TResult Function(int index) drop,
    required TResult Function(PickableItem item) pick,
  }) {
    return move(this.move);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Vector2 move)? move,
    TResult? Function(Vector2 position)? setPosition,
    TResult? Function(double damage)? damage,
    TResult? Function(int index)? drop,
    TResult? Function(PickableItem item)? pick,
  }) {
    return move?.call(this.move);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Vector2 move)? move,
    TResult Function(Vector2 position)? setPosition,
    TResult Function(double damage)? damage,
    TResult Function(int index)? drop,
    TResult Function(PickableItem item)? pick,
    required TResult orElse(),
  }) {
    if (move != null) {
      return move(this.move);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Move value) move,
    required TResult Function(_SetPosition value) setPosition,
    required TResult Function(_Damage value) damage,
    required TResult Function(_Drop value) drop,
    required TResult Function(_Pick value) pick,
  }) {
    return move(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Move value)? move,
    TResult? Function(_SetPosition value)? setPosition,
    TResult? Function(_Damage value)? damage,
    TResult? Function(_Drop value)? drop,
    TResult? Function(_Pick value)? pick,
  }) {
    return move?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Move value)? move,
    TResult Function(_SetPosition value)? setPosition,
    TResult Function(_Damage value)? damage,
    TResult Function(_Drop value)? drop,
    TResult Function(_Pick value)? pick,
    required TResult orElse(),
  }) {
    if (move != null) {
      return move(this);
    }
    return orElse();
  }
}

abstract class _Move implements PlayerEvent {
  const factory _Move(final Vector2 move) = _$MoveImpl;

  Vector2 get move;
  @JsonKey(ignore: true)
  _$$MoveImplCopyWith<_$MoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetPositionImplCopyWith<$Res> {
  factory _$$SetPositionImplCopyWith(
          _$SetPositionImpl value, $Res Function(_$SetPositionImpl) then) =
      __$$SetPositionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Vector2 position});
}

/// @nodoc
class __$$SetPositionImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$SetPositionImpl>
    implements _$$SetPositionImplCopyWith<$Res> {
  __$$SetPositionImplCopyWithImpl(
      _$SetPositionImpl _value, $Res Function(_$SetPositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_$SetPositionImpl(
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
    ));
  }
}

/// @nodoc

class _$SetPositionImpl implements _SetPosition {
  const _$SetPositionImpl(this.position);

  @override
  final Vector2 position;

  @override
  String toString() {
    return 'PlayerEvent.setPosition(position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetPositionImpl &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetPositionImplCopyWith<_$SetPositionImpl> get copyWith =>
      __$$SetPositionImplCopyWithImpl<_$SetPositionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Vector2 move) move,
    required TResult Function(Vector2 position) setPosition,
    required TResult Function(double damage) damage,
    required TResult Function(int index) drop,
    required TResult Function(PickableItem item) pick,
  }) {
    return setPosition(position);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Vector2 move)? move,
    TResult? Function(Vector2 position)? setPosition,
    TResult? Function(double damage)? damage,
    TResult? Function(int index)? drop,
    TResult? Function(PickableItem item)? pick,
  }) {
    return setPosition?.call(position);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Vector2 move)? move,
    TResult Function(Vector2 position)? setPosition,
    TResult Function(double damage)? damage,
    TResult Function(int index)? drop,
    TResult Function(PickableItem item)? pick,
    required TResult orElse(),
  }) {
    if (setPosition != null) {
      return setPosition(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Move value) move,
    required TResult Function(_SetPosition value) setPosition,
    required TResult Function(_Damage value) damage,
    required TResult Function(_Drop value) drop,
    required TResult Function(_Pick value) pick,
  }) {
    return setPosition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Move value)? move,
    TResult? Function(_SetPosition value)? setPosition,
    TResult? Function(_Damage value)? damage,
    TResult? Function(_Drop value)? drop,
    TResult? Function(_Pick value)? pick,
  }) {
    return setPosition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Move value)? move,
    TResult Function(_SetPosition value)? setPosition,
    TResult Function(_Damage value)? damage,
    TResult Function(_Drop value)? drop,
    TResult Function(_Pick value)? pick,
    required TResult orElse(),
  }) {
    if (setPosition != null) {
      return setPosition(this);
    }
    return orElse();
  }
}

abstract class _SetPosition implements PlayerEvent {
  const factory _SetPosition(final Vector2 position) = _$SetPositionImpl;

  Vector2 get position;
  @JsonKey(ignore: true)
  _$$SetPositionImplCopyWith<_$SetPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DamageImplCopyWith<$Res> {
  factory _$$DamageImplCopyWith(
          _$DamageImpl value, $Res Function(_$DamageImpl) then) =
      __$$DamageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double damage});
}

/// @nodoc
class __$$DamageImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$DamageImpl>
    implements _$$DamageImplCopyWith<$Res> {
  __$$DamageImplCopyWithImpl(
      _$DamageImpl _value, $Res Function(_$DamageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damage = null,
  }) {
    return _then(_$DamageImpl(
      null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DamageImpl implements _Damage {
  const _$DamageImpl(this.damage);

  @override
  final double damage;

  @override
  String toString() {
    return 'PlayerEvent.damage(damage: $damage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DamageImpl &&
            (identical(other.damage, damage) || other.damage == damage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, damage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DamageImplCopyWith<_$DamageImpl> get copyWith =>
      __$$DamageImplCopyWithImpl<_$DamageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Vector2 move) move,
    required TResult Function(Vector2 position) setPosition,
    required TResult Function(double damage) damage,
    required TResult Function(int index) drop,
    required TResult Function(PickableItem item) pick,
  }) {
    return damage(this.damage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Vector2 move)? move,
    TResult? Function(Vector2 position)? setPosition,
    TResult? Function(double damage)? damage,
    TResult? Function(int index)? drop,
    TResult? Function(PickableItem item)? pick,
  }) {
    return damage?.call(this.damage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Vector2 move)? move,
    TResult Function(Vector2 position)? setPosition,
    TResult Function(double damage)? damage,
    TResult Function(int index)? drop,
    TResult Function(PickableItem item)? pick,
    required TResult orElse(),
  }) {
    if (damage != null) {
      return damage(this.damage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Move value) move,
    required TResult Function(_SetPosition value) setPosition,
    required TResult Function(_Damage value) damage,
    required TResult Function(_Drop value) drop,
    required TResult Function(_Pick value) pick,
  }) {
    return damage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Move value)? move,
    TResult? Function(_SetPosition value)? setPosition,
    TResult? Function(_Damage value)? damage,
    TResult? Function(_Drop value)? drop,
    TResult? Function(_Pick value)? pick,
  }) {
    return damage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Move value)? move,
    TResult Function(_SetPosition value)? setPosition,
    TResult Function(_Damage value)? damage,
    TResult Function(_Drop value)? drop,
    TResult Function(_Pick value)? pick,
    required TResult orElse(),
  }) {
    if (damage != null) {
      return damage(this);
    }
    return orElse();
  }
}

abstract class _Damage implements PlayerEvent {
  const factory _Damage(final double damage) = _$DamageImpl;

  double get damage;
  @JsonKey(ignore: true)
  _$$DamageImplCopyWith<_$DamageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DropImplCopyWith<$Res> {
  factory _$$DropImplCopyWith(
          _$DropImpl value, $Res Function(_$DropImpl) then) =
      __$$DropImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$DropImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$DropImpl>
    implements _$$DropImplCopyWith<$Res> {
  __$$DropImplCopyWithImpl(_$DropImpl _value, $Res Function(_$DropImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$DropImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DropImpl implements _Drop {
  const _$DropImpl(this.index);

  @override
  final int index;

  @override
  String toString() {
    return 'PlayerEvent.drop(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DropImplCopyWith<_$DropImpl> get copyWith =>
      __$$DropImplCopyWithImpl<_$DropImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Vector2 move) move,
    required TResult Function(Vector2 position) setPosition,
    required TResult Function(double damage) damage,
    required TResult Function(int index) drop,
    required TResult Function(PickableItem item) pick,
  }) {
    return drop(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Vector2 move)? move,
    TResult? Function(Vector2 position)? setPosition,
    TResult? Function(double damage)? damage,
    TResult? Function(int index)? drop,
    TResult? Function(PickableItem item)? pick,
  }) {
    return drop?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Vector2 move)? move,
    TResult Function(Vector2 position)? setPosition,
    TResult Function(double damage)? damage,
    TResult Function(int index)? drop,
    TResult Function(PickableItem item)? pick,
    required TResult orElse(),
  }) {
    if (drop != null) {
      return drop(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Move value) move,
    required TResult Function(_SetPosition value) setPosition,
    required TResult Function(_Damage value) damage,
    required TResult Function(_Drop value) drop,
    required TResult Function(_Pick value) pick,
  }) {
    return drop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Move value)? move,
    TResult? Function(_SetPosition value)? setPosition,
    TResult? Function(_Damage value)? damage,
    TResult? Function(_Drop value)? drop,
    TResult? Function(_Pick value)? pick,
  }) {
    return drop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Move value)? move,
    TResult Function(_SetPosition value)? setPosition,
    TResult Function(_Damage value)? damage,
    TResult Function(_Drop value)? drop,
    TResult Function(_Pick value)? pick,
    required TResult orElse(),
  }) {
    if (drop != null) {
      return drop(this);
    }
    return orElse();
  }
}

abstract class _Drop implements PlayerEvent {
  const factory _Drop(final int index) = _$DropImpl;

  int get index;
  @JsonKey(ignore: true)
  _$$DropImplCopyWith<_$DropImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PickImplCopyWith<$Res> {
  factory _$$PickImplCopyWith(
          _$PickImpl value, $Res Function(_$PickImpl) then) =
      __$$PickImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PickableItem item});

  $PickableItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$PickImplCopyWithImpl<$Res>
    extends _$PlayerEventCopyWithImpl<$Res, _$PickImpl>
    implements _$$PickImplCopyWith<$Res> {
  __$$PickImplCopyWithImpl(_$PickImpl _value, $Res Function(_$PickImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$PickImpl(
      null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as PickableItem,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PickableItemCopyWith<$Res> get item {
    return $PickableItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$PickImpl implements _Pick {
  const _$PickImpl(this.item);

  @override
  final PickableItem item;

  @override
  String toString() {
    return 'PlayerEvent.pick(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PickImplCopyWith<_$PickImpl> get copyWith =>
      __$$PickImplCopyWithImpl<_$PickImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Vector2 move) move,
    required TResult Function(Vector2 position) setPosition,
    required TResult Function(double damage) damage,
    required TResult Function(int index) drop,
    required TResult Function(PickableItem item) pick,
  }) {
    return pick(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Vector2 move)? move,
    TResult? Function(Vector2 position)? setPosition,
    TResult? Function(double damage)? damage,
    TResult? Function(int index)? drop,
    TResult? Function(PickableItem item)? pick,
  }) {
    return pick?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Vector2 move)? move,
    TResult Function(Vector2 position)? setPosition,
    TResult Function(double damage)? damage,
    TResult Function(int index)? drop,
    TResult Function(PickableItem item)? pick,
    required TResult orElse(),
  }) {
    if (pick != null) {
      return pick(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Move value) move,
    required TResult Function(_SetPosition value) setPosition,
    required TResult Function(_Damage value) damage,
    required TResult Function(_Drop value) drop,
    required TResult Function(_Pick value) pick,
  }) {
    return pick(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Move value)? move,
    TResult? Function(_SetPosition value)? setPosition,
    TResult? Function(_Damage value)? damage,
    TResult? Function(_Drop value)? drop,
    TResult? Function(_Pick value)? pick,
  }) {
    return pick?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Move value)? move,
    TResult Function(_SetPosition value)? setPosition,
    TResult Function(_Damage value)? damage,
    TResult Function(_Drop value)? drop,
    TResult Function(_Pick value)? pick,
    required TResult orElse(),
  }) {
    if (pick != null) {
      return pick(this);
    }
    return orElse();
  }
}

abstract class _Pick implements PlayerEvent {
  const factory _Pick(final PickableItem item) = _$PickImpl;

  PickableItem get item;
  @JsonKey(ignore: true)
  _$$PickImplCopyWith<_$PickImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerState {
  Vector2 get speed => throw _privateConstructorUsedError;
  bool get moving => throw _privateConstructorUsedError;
  Vector2 get position => throw _privateConstructorUsedError;
  double get health => throw _privateConstructorUsedError;
  Map<int, PickableItem> get items => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  double get maxWeight => throw _privateConstructorUsedError;
  Difficulty get difficulty => throw _privateConstructorUsedError;
  Map<allGoods, bool> get goods => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerStateCopyWith<PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
          PlayerState value, $Res Function(PlayerState) then) =
      _$PlayerStateCopyWithImpl<$Res, PlayerState>;
  @useResult
  $Res call(
      {Vector2 speed,
      bool moving,
      Vector2 position,
      double health,
      Map<int, PickableItem> items,
      double weight,
      double maxWeight,
      Difficulty difficulty,
      Map<allGoods, bool> goods});
}

/// @nodoc
class _$PlayerStateCopyWithImpl<$Res, $Val extends PlayerState>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? moving = null,
    Object? position = null,
    Object? health = null,
    Object? items = null,
    Object? weight = null,
    Object? maxWeight = null,
    Object? difficulty = null,
    Object? goods = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Vector2,
      moving: null == moving
          ? _value.moving
          : moving // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      health: null == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<int, PickableItem>,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      maxWeight: null == maxWeight
          ? _value.maxWeight
          : maxWeight // ignore: cast_nullable_to_non_nullable
              as double,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
      goods: null == goods
          ? _value.goods
          : goods // ignore: cast_nullable_to_non_nullable
              as Map<allGoods, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStateImplCopyWith<$Res>
    implements $PlayerStateCopyWith<$Res> {
  factory _$$PlayerStateImplCopyWith(
          _$PlayerStateImpl value, $Res Function(_$PlayerStateImpl) then) =
      __$$PlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Vector2 speed,
      bool moving,
      Vector2 position,
      double health,
      Map<int, PickableItem> items,
      double weight,
      double maxWeight,
      Difficulty difficulty,
      Map<allGoods, bool> goods});
}

/// @nodoc
class __$$PlayerStateImplCopyWithImpl<$Res>
    extends _$PlayerStateCopyWithImpl<$Res, _$PlayerStateImpl>
    implements _$$PlayerStateImplCopyWith<$Res> {
  __$$PlayerStateImplCopyWithImpl(
      _$PlayerStateImpl _value, $Res Function(_$PlayerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? moving = null,
    Object? position = null,
    Object? health = null,
    Object? items = null,
    Object? weight = null,
    Object? maxWeight = null,
    Object? difficulty = null,
    Object? goods = null,
  }) {
    return _then(_$PlayerStateImpl(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Vector2,
      moving: null == moving
          ? _value.moving
          : moving // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      health: null == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<int, PickableItem>,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      maxWeight: null == maxWeight
          ? _value.maxWeight
          : maxWeight // ignore: cast_nullable_to_non_nullable
              as double,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
      goods: null == goods
          ? _value._goods
          : goods // ignore: cast_nullable_to_non_nullable
              as Map<allGoods, bool>,
    ));
  }
}

/// @nodoc

class _$PlayerStateImpl implements _PlayerState {
  const _$PlayerStateImpl(
      {required this.speed,
      this.moving = false,
      required this.position,
      this.health = 1,
      final Map<int, PickableItem> items = const {},
      this.weight = 0,
      this.maxWeight = 50,
      required this.difficulty,
      required final Map<allGoods, bool> goods})
      : _items = items,
        _goods = goods;

  @override
  final Vector2 speed;
  @override
  @JsonKey()
  final bool moving;
  @override
  final Vector2 position;
  @override
  @JsonKey()
  final double health;
  final Map<int, PickableItem> _items;
  @override
  @JsonKey()
  Map<int, PickableItem> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  @override
  @JsonKey()
  final double weight;
  @override
  @JsonKey()
  final double maxWeight;
  @override
  final Difficulty difficulty;
  final Map<allGoods, bool> _goods;
  @override
  Map<allGoods, bool> get goods {
    if (_goods is EqualUnmodifiableMapView) return _goods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_goods);
  }

  @override
  String toString() {
    return 'PlayerState(speed: $speed, moving: $moving, position: $position, health: $health, items: $items, weight: $weight, maxWeight: $maxWeight, difficulty: $difficulty, goods: $goods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStateImpl &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.moving, moving) || other.moving == moving) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.health, health) || other.health == health) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.maxWeight, maxWeight) ||
                other.maxWeight == maxWeight) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._goods, _goods));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      speed,
      moving,
      position,
      health,
      const DeepCollectionEquality().hash(_items),
      weight,
      maxWeight,
      difficulty,
      const DeepCollectionEquality().hash(_goods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      __$$PlayerStateImplCopyWithImpl<_$PlayerStateImpl>(this, _$identity);
}

abstract class _PlayerState implements PlayerState {
  const factory _PlayerState(
      {required final Vector2 speed,
      final bool moving,
      required final Vector2 position,
      final double health,
      final Map<int, PickableItem> items,
      final double weight,
      final double maxWeight,
      required final Difficulty difficulty,
      required final Map<allGoods, bool> goods}) = _$PlayerStateImpl;

  @override
  Vector2 get speed;
  @override
  bool get moving;
  @override
  Vector2 get position;
  @override
  double get health;
  @override
  Map<int, PickableItem> get items;
  @override
  double get weight;
  @override
  double get maxWeight;
  @override
  Difficulty get difficulty;
  @override
  Map<allGoods, bool> get goods;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
