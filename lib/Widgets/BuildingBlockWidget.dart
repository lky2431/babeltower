import 'package:flutter/material.dart';

import '../model/BuildingBlock.dart';

class BuildingBlockWidget extends StatelessWidget {
  const BuildingBlockWidget(this.blockIndex, {this.rotation = 0});

  final int blockIndex;
  final int rotation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          BuildingBlock block = availableBlocks[blockIndex]!;
          List<int> blocks = block.rotate(rotation);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (j) => Row(
                      children: List.generate(3, (i) {
                        if (blocks.contains(3 * j + i)) {
                          return Container(
                            height: constraints.maxWidth / 3,
                            width: constraints.maxWidth / 3,
                            child: Image.asset("assets/images/block.png"),
                          );
                        }
                        return Container(
                          width: constraints.maxWidth / 3,
                        );
                      }),
                    )),
          );
        },
      ),
    );
  }
}
