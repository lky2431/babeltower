import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/bloc/player_bloc.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:tuple/tuple.dart';

import '../tool/mapGenerator.dart';
import 'TileComponent.dart';
import 'ZombieComponent.dart';

class TileGenerationComponent extends PositionComponent
    with FlameBlocReader<PlayerBloc, PlayerState>, HasGameRef<BabelTowerGame> {
  TileGenerationComponent();

  late Vector2 _size;
  Map<Tuple2, TileComponent> addedTile = {};
  late Map<Tuple2, (int, int)> tiles;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _size = gameRef.size;

    tiles = getPossibleMap();

    await add(FlameBlocListener<PlayerBloc, PlayerState>(onNewState: (state) {
      updateAccordingPosition(state.position);
    }));
    updateAccordingPosition(bloc.state.position);
  }

  updateAccordingPosition(Vector2 playerPosition) {
    for (Tuple2 tuple in tiles.keys) {
      if (playerPosition.x + _size.x > tuple.item1 * 80 &&
          playerPosition.x - _size.x < tuple.item1 * 80 &&
          playerPosition.y + _size.y > tuple.item2 * 80 &&
          playerPosition.y - _size.y < tuple.item2 * 80) {
        if (!addedTile.containsKey(tuple)) {
          TileComponent tile = TileComponent(
              index: tiles[tuple]!.$1,
              rotation: tiles[tuple]!.$2,
              pos: Vector2(tuple.item1.toDouble(), tuple.item2.toDouble()));
          add(tile);
          addedTile[tuple] = tile;
        }
      } else {
        if (addedTile.containsKey(tuple)) {
          remove(addedTile[tuple]!);
          addedTile.remove(tuple);
        }
      }
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _size = size * 1.2;
  }

  @override
  void onRemove() {}


}
