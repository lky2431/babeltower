import 'package:babeltower/Widgets/BuildingBlockWidget.dart';
import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:babeltower/model/PickableItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../bloc/player/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryDialog extends StatelessWidget {
  const SummaryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/cover.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
      ),
      child: SizedBox.expand(
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            double price = 0;
            Map<int, int> blocks = {};
            List<int> blocksList = [];
            state.items.forEach((key, value) {
              if (value is Normal) {
                price += (value).price;
              }
              if (value is Building) {
                blocks[value.blockIndex] = (blocks[value.blockIndex] ?? 0) + 1;
                blocksList.add(value.blockIndex);
              }
            });
            double numsum =
                context.read<GlobalBloc>().state.gameContent!.money + price - 2;
            double health = state.health +
                switch (state.difficulty) {
                  Difficulty.simple => 0.6,
                  Difficulty.real => 0.45,
                  Difficulty.tough => 0.3,
                };
            if (health > 1) {
              health = 1;
            }
            if (numsum < 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ..._buildNoMoneyInfo(price, numsum),
                  ElevatedButton(
                      onPressed: () {
                        context.read<GlobalBloc>().add(GlobalEvent.quit());
                      },
                      child: Text("Quit"))
                ],
              );
            }

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 500),
                child: OrientationBuilder(builder: (context, orientation) {
                  if (orientation == Orientation.portrait) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (blocksList.isNotEmpty)
                                  ..._buildBlockList(blocksList),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                ..._buildMoneyinfo(price, numsum),
                              ],
                            ),
                          ),
                        ),
                        _buildOKButton(context, blocks, numsum, health)
                      ],
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Summary",
                        style: TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            if (blocksList.isNotEmpty)
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [..._buildBlockList(blocksList)],
                                  ),
                                ),
                              ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildMoneyinfo(price, numsum),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildOKButton(context, blocks, numsum, health),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildBlockList(List<int> blocksList) {
    return [
      Text("building block:", style: TextStyle(fontSize: 18)),
      SizedBox(
        height: 8,
      ),
      Wrap(
        children: blocksList
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                      height: 80, width: 80, child: BuildingBlockWidget(e)),
                ))
            .toList(),
      ),
    ];
  }

  ElevatedButton _buildOKButton(BuildContext context, Map<int, int> blocks,
      double numsum, double health) {
    return ElevatedButton(
        onPressed: () {
          GlobalBloc bloc = context.read<GlobalBloc>();
          bloc.add(GlobalEvent.addBlock(blocks));
          bloc.add(GlobalEvent.updateMoney(numsum));
          bloc.add(GlobalEvent.updateHealth(health));
          if (bloc.state.gameContent!.goods.values.contains(false)) {
            bloc.add(GlobalEvent.changeStage(GameStage.shop));
          } else {
            bloc.add(GlobalEvent.changeStage(GameStage.tower));
          }
        },
        child: Text("OK"));
  }

  List<Widget> _buildMoneyinfo(double price, double numsum) {
    return [
      Text("money earnt: \$${price.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 16)),
      SizedBox(
        height: 12,
      ),
      Text("family expense: \$2", style: TextStyle(fontSize: 16)),
      SizedBox(
        height: 12,
      ),
      Text("change: \$${(price - 2).toStringAsFixed(2)}",
          style: TextStyle(fontSize: 16)),
      SizedBox(
        height: 12,
      ),
      Text(
        "saving: \$${numsum.toStringAsFixed(2)}",
        style: TextStyle(fontSize: 16),
      ),
    ];
  }

  List<Widget> _buildNoMoneyInfo(double price, double numsum) {
    return [
      Text("money earnt: \$${price.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 16)),
      Text("saving: \$${(numsum + 2).toStringAsFixed(2)}",
          style: TextStyle(fontSize: 16)),
      Text("family expense: \$2", style: TextStyle(fontSize: 16)),
      Text("You don't have enough money to feed your money",
          style: TextStyle(fontSize: 16))
    ];
  }
}
