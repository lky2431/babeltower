import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

mixin Indicatable on PositionComponent {
  bool isAcitve();
  GlobalKey get globalKey;
  Future<SpriteComponent> indicatorSprite();
}
