import 'dart:math';
import 'package:babeltower/config.dart';
import 'package:tuple/tuple.dart';

Map<Tuple2, (int, int)> getPossibleMap() {
  Map<Tuple2, (int, int)> position = {Tuple2(0, 0): (1, 0)};
  List<Tuple2> positionList = [];
  int number = mapSize;
  for (int i = 0; i <= number; i++) {
    for (int j = 0; j <= number; j++) {
      positionList.add(Tuple2(i, j));
    }
  }
  Map<(int, int), List<int>> pool = {(1, 0): []};
  for (int i = 2; i <= 5; i++) {
    for (int j = 0; j < 4; j++) {
      pool[(i, j)] = findPossibleTile(i, j);
    }
  }


  Map<int, int> reverseDirection = {
    0: 3,
    1: 6,
    2: 5,
    3: 0,
    4: 7,
    5: 6,
    6: 5,
    7: 4
  };

  positionList.sort((a, b) =>
      (a.item1.abs() + a.item2.abs() - b.item1.abs() - b.item2.abs()));

  for (Tuple2 pos in positionList) {
    if (position[pos] == null) {
      List<(int, int)> possible = [];
      Tuple2 top = Tuple2(pos.item1, pos.item2 - 1);
      Tuple2 bottom = Tuple2(pos.item1, pos.item2 + 1);
      Tuple2 left = Tuple2(pos.item1 - 1, pos.item2);
      Tuple2 right = Tuple2(pos.item1 + 1, pos.item2);

      Map<Tuple2, List<int>> directions = {
        top: [3, 4],
        bottom: [0, 7],
        left: [1, 2],
        right: [5, 6]
      };

      List<int> condition = [];
      List<int> negativeCondition = [];

      for (Tuple2 direction in directions.keys) {
        if (position[direction] != null) {
          (int, int) tileinfo = position[direction]!;
          condition.addAll(findPossibleTile(tileinfo.$1, tileinfo.$2)
              .where((e) => directions[direction]!.contains(e))
              .map((e) => reverseDirection[e]!)
              .toList());

          negativeCondition.addAll(
              directions[direction]!.map((e) => reverseDirection[e]!).toList());
        }
      }
      for (int c in condition) {
        negativeCondition.remove(c);
      }

      for ((int, int) tileinfo in pool.keys) {
        if (pool[tileinfo]!.isMatchTile(condition) &&
            pool[tileinfo]!.isNotContainAny(negativeCondition)) {
          possible.add(tileinfo);
        }
      }
      if (possible.contains((1, 0))) {
        possible.add((1, 0));
        possible.add((1, 0));
        possible.add((1, 0));
        possible.add((1, 0));
      }

      position[pos] = possible[Random().nextInt(possible.length)];
    }
  }

  return position;
}

List<int> findPossibleTile(int index, int rotation) {
  switch (index) {
    case 2:
      return [2, 3].rotate(rotation);
    case 3:
      return [0, 1, 6, 7].rotate(rotation);
    case 4:
      return [0, 1, 2, 3, 4, 5, 6, 7].rotate(rotation);
    case 5:
      return [0, 1, 2, 3, 4, 5].rotate(rotation);
    default:
      return [].cast<int>();
  }
}

extension on List<int> {
  List<int> rotate(int time) {
    return map((e) {
      if (e + 2 * time > 7) {
        return e + 2 * time - 8;
      }
      return e + 2 * time;
    }).toList();
  }

  bool isMatchTile(List<int> other) {
    for (int i in other) {
      if (!contains(i)) {
        return false;
      }
    }
    return true;
  }

  bool isNotContainAny(List<int> other) {
    for (int i in other) {
      if (contains(i)) {
        return false;
      }
    }
    return true;
  }
}
