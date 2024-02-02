import 'package:flame/components.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'PlayerProvider.g.dart';

@riverpod
Vector2 playerDirection (PlayerDirectionRef ref){
  return Vector2(0, 0);
}