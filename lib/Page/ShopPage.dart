import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Goods.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Goods? good;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        Map<allGoods, bool> purchased = state.gameContent!.goods;
        double money = state.gameContent!.money;
        return Container(
          decoration: BoxDecoration(color: Colors.black),
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  _buildShopTitle(),
                  SizedBox(
                    height: 12,
                  ),
                  _buildMoney(money),
                  SizedBox(
                    height: 24,
                  ),
                  Text(good != null ? "${good!.description}" : ""),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount:
                          (MediaQuery.of(context).size.width / 150).truncate(),
                      children: availableGoods
                          .where((element) => !purchased[element.goods]!)
                          .map((e) => _PurchaseGridItemWidget(
                              good: e,
                              onTap: () {
                                setState(() {
                                  good = e;
                                });
                              },
                              selected: e.goods == good?.goods))
                          .toList(),
                    ),
                  ),
                  buildPurchaseButton(money, context),
                  SizedBox(
                    height: 12,
                  ),
                  buildQuitButton(context)
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildShopTitle(),
                      SizedBox(
                        height: 24,
                      ),
                      _buildMoney(money),
                      SizedBox(
                        height: 24,
                      ),
                      buildPurchaseButton(money, context),
                      SizedBox(
                        height: 12,
                      ),
                      buildQuitButton(context)
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                      children: availableGoods
                          .where((element) => !purchased[element.goods]!)
                          .map((e) => _PurchaseListItemWidget(
                                good: e,
                                onTap: () {
                                  setState(() {
                                    good = e;
                                  });
                                },
                                selected: e.goods == good?.goods,
                              ))
                          .toList()),
                )
              ],
            );
          }),
        );
      },
    );
  }

  Container buildQuitButton(BuildContext context) {
    return Container(
      width: 120,
      child: FilledButton.tonal(
          onPressed: () {
            context.read<GlobalBloc>().add(GlobalEvent.changeStage(GameStage.tower));
          },
          child: Text("Quit")),
    );
  }

  Text _buildMoney(double money) {
    return Text("your saving: \$${money.toStringAsFixed(2)}", style: TextStyle(fontSize: 24));
  }

  Text _buildShopTitle() {
    return Text(
      "Shop",
      style: TextStyle(fontSize: 36, fontFamily: "Destroy"),
    );
  }

  Widget buildPurchaseButton(double money, BuildContext context) {
    return Container(
      width: 120,
      child: ElevatedButton(
          onPressed: () {
            if (good != null) {
              if (money < good!.price) {
                return;
              }
              context.read<GlobalBloc>().add(GlobalEvent.purchase(good!));
            }
          },
          child: Text("Purchase")),
    );
  }
}

class _PurchaseGridItemWidget extends StatelessWidget {
  const _PurchaseGridItemWidget(
      {required this.good, required this.onTap, required this.selected});

  final Goods good;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? Colors.white : Colors.white30),
          ),
          child: Column(
            children: [
              Image.asset("assets/images/${good.image}.png"),
              Text(good.name),
              Text("\$${good.price}"),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseListItemWidget extends StatelessWidget {
  const _PurchaseListItemWidget(
      {required this.good, required this.onTap, required this.selected});

  final Goods good;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? Colors.white : Colors.white30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset("assets/images/${good.image}.png"),
                Column(
                  children: [
                    Text(good.name),
                    Text("\$${good.price}"),
                  ],
                ),
                SizedBox(
                  width: 24,
                ),
                Text(good.description)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
