import 'dart:ffi';

import 'package:babeltower/Widgets/BuildingBlockWidget.dart';
import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:babeltower/model/PickableItem.dart';
import 'package:flutter/material.dart';

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
        child: BlocBuilder<PlayerBloc, PlayerState>(
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

            return OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Summary",
                      style: TextStyle(fontSize: 28),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    if (blocksList.isNotEmpty) ..._buildBlockList(blocksList),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    ..._buildMoneyinfo(price, numsum),
                    SizedBox(
                      height: 16,
                    ),
                    _buildOKButton(context, blocks, numsum)
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Summary",
                        style: TextStyle(fontSize: 28),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      _buildOKButton(context, blocks, numsum)
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  if (blocksList.isNotEmpty)
                    Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [..._buildBlockList(blocksList)],
                      ),
                    ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildMoneyinfo(price, numsum),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }

  List<Widget> _buildBlockList(List<int> blocksList) {
    return [
      Text("building block:", style: TextStyle(fontSize: 22)),
      SizedBox(
        height: 12,
      ),
      Wrap(
        children: blocksList
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 100, width: 100, child: BuildingBlockWidget(e)),
                ))
            .toList(),
      ),
    ];
  }

  ElevatedButton _buildOKButton(
      BuildContext context, Map<int, int> blocks, double numsum) {
    return ElevatedButton(
        onPressed: () {
          GlobalBloc bloc = context.read<GlobalBloc>();
          bloc.add(GlobalEvent.addBlock(blocks));
          bloc.add(GlobalEvent.updateMoney(numsum));
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
          style: TextStyle(fontSize: 22)),
      SizedBox(
        height: 12,
      ),
      Text("family expense: \$2", style: TextStyle(fontSize: 22)),
      SizedBox(
        height: 12,
      ),
      Text("change: \$${(price - 2).toStringAsFixed(2)}",
          style: TextStyle(fontSize: 22)),
      SizedBox(
        height: 12,
      ),
      Text("saving: \$${numsum}"),
    ];
  }
}
