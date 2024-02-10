import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:tuple/tuple.dart';

import '../tool/mapGenerator.dart';
import 'TileComponent.dart';


class TileGenerationComponent extends PositionComponent
    with FlameBlocReader<PlayerBloc, PlayerState>, HasGameRef<BabelTowerGame> {
  TileGenerationComponent();

  Map<Tuple2, TileComponent> addedTile = {};
  late Map<Tuple2, (int, int)> tiles;
  late (int, int, int, int) boundary;
  (int, int, int, int)? lastboundary;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority=-10;
    tiles = getPossibleMap();
    await add(FlameBlocListener<PlayerBloc, PlayerState>(onNewState: (state) {
      updateAccordingPosition();
    }));
  }

  @override
  void onMount() {
    super.onMount();
    Future.delayed(Duration(milliseconds: 10),(){
      updateAccordingPosition();
    });

  }

  updateAccordingPosition() {
    double lefttop_x = camPosition.x - _size.x / 2 - 80;
    double rightbottom_x = camPosition.x + _size.x / 2 + 80;
    double lefttop_y = camPosition.y - _size.y / 2 - 80;
    double rightbottom_y = camPosition.y + _size.y / 2 + 80;
    int l_index_x = (lefttop_x / 80).floor();
    int h_index_x = (rightbottom_x / 80).ceil();
    int l_index_y = (lefttop_y / 80).floor();
    int h_index_y = (rightbottom_y / 80).ceil();
    boundary = (l_index_x, h_index_x, l_index_y, h_index_y);
    for (int i = l_index_x; i < h_index_x; i++) {
      for (int j = l_index_y; j < h_index_y; j++) {
        addTile(Tuple2(i, j));
      }
    }
    if (lastboundary != null) {
      if (boundary.$1 > lastboundary!.$1) {
        for (int i = l_index_y; i < h_index_y; i++) {
          removeTile(Tuple2(l_index_x, i));
        }
      }

      if (boundary.$2 < lastboundary!.$2) {
        for (int i = l_index_y; i < h_index_y; i++) {
          removeTile(Tuple2(h_index_x, i));
        }
      }

      if (boundary.$3 > lastboundary!.$3) {
        for (int i = l_index_y; i < h_index_y; i++) {
          removeTile(Tuple2(i, l_index_y));
        }
      }

      if (boundary.$4 < lastboundary!.$4) {
        for (int i = l_index_y; i < h_index_y; i++) {
          removeTile(Tuple2(i, h_index_y));
        }
      }
    }

    lastboundary = boundary;
  }

  Vector2 get camPosition => gameRef.camera.viewfinder.position;

  Vector2 get _size => gameRef.size;

  addTile(Tuple2 tuple) {
    if (!addedTile.containsKey(tuple) && tiles.containsKey(tuple)) {
      TileComponent tile = TileComponent(
          index: tiles[tuple]!.$1,
          rotation: tiles[tuple]!.$2,
          pos: Vector2(tuple.item1.toDouble(), tuple.item2.toDouble()));
      add(tile);
      addedTile[tuple] = tile;
    }
  }

  removeTile(Tuple2 tuple) {
    if (addedTile.containsKey(tuple)) {
      remove(addedTile[tuple]!);
      addedTile.remove(tuple);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }

  @override
  void onRemove() {}
}
