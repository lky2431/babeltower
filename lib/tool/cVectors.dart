import 'package:flame/components.dart';

class Vectors {
  Vectors._internal();

  static Vectors instance = Vectors._internal();

  double ratio = 1;

  setRatio(Vector2 size) {
    double shorter = size.x;
    if (size.y < shorter) {
      shorter = size.y;
    }
    ratio = shorter / 960;
  }
}

Vector2 v32 = Vector2.all(32) * Vectors.instance.ratio;
Vector2 v48=Vector2.all(48) * Vectors.instance.ratio;
Vector2 v64 = Vector2.all(64) * Vectors.instance.ratio;
Vector2 v96 = Vector2.all(96) * Vectors.instance.ratio;
Vector2 v128 = Vector2.all(128) * Vectors.instance.ratio;
Vector2 v196 = Vector2.all(196) * Vectors.instance.ratio;
Vector2 v256 = Vector2.all(256) * Vectors.instance.ratio;
double vratio=Vectors.instance.ratio;
