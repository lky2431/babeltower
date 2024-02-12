class BuildingBlock {
  /// 0 1 2
  /// 3 4 5
  /// 6 7 8
  BuildingBlock({required this.blocks});
  final List<int> blocks;

  int _rotateRule(int i) {
    switch (i) {
      case 0:
        return 6;
      case 1:
        return 3;
      case 2:
        return 0;
      case 3:
        return 7;
      case 5:
        return 1;
      case 6:
        return 8;
      case 7:
        return 5;
      case 8:
        return 2;
      default:
        return 4;
    }
  }

  List<int> rotate(int times) {
    List<int> _temp = List.of(blocks);
    for (int i = 0; i < times; i++) {
      _temp = _temp.map((e) => _rotateRule(e)).toList();
    }
    return _temp;
  }
}

Map<int, BuildingBlock> availableBlocks = {
  0: BuildingBlock(blocks: [4, 6, 7]),
  1: BuildingBlock(blocks: [4, 7, 8, 6]),
  2: BuildingBlock(blocks: [3, 4, 5]),
  3: BuildingBlock(blocks: [3, 6, 7, 8]),
  4: BuildingBlock(blocks: [3, 4, 6, 7]),
  5: BuildingBlock(blocks: [4, 7]),
  6: BuildingBlock(blocks: [3, 6, 7, 8, 5]),
};
