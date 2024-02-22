import 'package:freezed_annotation/freezed_annotation.dart';

part "PickableItem.freezed.dart";

@freezed
sealed class PickableItem with _$PickableItem {
  const factory PickableItem.building(String description, int blockIndex, int weight) = Building;
  const factory PickableItem.normal(String description, String image,double weight, double price) = Normal;
}