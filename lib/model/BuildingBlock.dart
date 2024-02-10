class BuildingBlock {
  /// 0 1 2
  /// 3 4 5
  /// 6 7 8
  BuildingBlock({required this.blocks});
  final List<int> blocks;
}

List<BuildingBlock> availableBlocks = [
  BuildingBlock(blocks: [4, 6, 7]),
  BuildingBlock(blocks: [4, 7, 8, 6]),
  BuildingBlock(blocks: [3, 4, 5]),
  BuildingBlock(blocks: [3, 6, 7, 8]),
  BuildingBlock(blocks: [3, 4, 6, 7]),
  BuildingBlock(blocks: [4, 7]),
  BuildingBlock(blocks: [3, 6, 7, 8, 5]),
];
