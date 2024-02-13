import 'dart:math';

import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Components/BuildingBlockComponent.dart';
import 'package:babeltower/Widgets/BuildingBlockWidget.dart';

import 'package:babeltower/tool/cVectors.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../bloc/player/player_bloc.dart';

import '../model/PickableItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagDialog extends StatefulWidget {
  const BagDialog(this.game);

  final BabelTowerGame game;

  @override
  State<BagDialog> createState() => _BagDialogState();
}

class _BagDialogState extends State<BagDialog> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(12)),
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                if (height < width * 10 / 6) {
                  width = height * 6 / 10;
                }
                return BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      "Weight: ${state.weight.toInt()}/50")),
                              IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    widget.game.overlays.remove("Bag");
                                    widget.game.resumeEngine();
                                  })
                            ],
                          ),
                        ),
                        ...List.generate(
                            5,
                            (j) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      6,
                                      (i) => ItemWidget(
                                            index: i + 6 * j,
                                            size: width / 6,
                                            onTap: () {
                                              if (state.items[i + 6 * j] !=
                                                  null) {
                                                setState(() {
                                                  selectedIndex = i + 6 * j;
                                                });
                                              }
                                            },
                                            child: state.items[i + 6 * j],
                                            selected:
                                                selectedIndex == i + 6 * j,
                                          )),
                                )),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: Colors.white54)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(selectedIndex == null ||
                                              state.items[selectedIndex] == null
                                          ? "Select an item"
                                          : state.items[selectedIndex]!
                                              .description),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "item weight: ${(selectedIndex == null || state.items[selectedIndex] == null ? '--' : state.items[selectedIndex]!.weight)}"),
                                  )
                                ],
                              ),
                            )),
                            FilledButton.tonal(
                                onPressed: () {
                                  if (selectedIndex == null) {
                                    return;
                                  }
                                  context
                                      .read<PlayerBloc>()
                                      .add(PlayerEvent.drop(selectedIndex!));
                                  if (state.items[selectedIndex]! is Building) {
                                    BuildingBlockComponent component =
                                        BuildingBlockComponent(
                                            //gameRef: widget.game,
                                            index: (state.items[selectedIndex]!
                                                    as Building)
                                                .blockIndex,
                                            initialPosition: state.position +
                                                (v196..rotate(pi)));
                                    widget.game.provider.add(component);
                                    widget.game.indicatorManager.components
                                        .add(component);
                                  } else {}
                                },
                                child: Text("Drop"))
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {required this.index,
      required this.size,
      required this.onTap,
      required this.selected,
      this.child});

  final int index;
  final double size;
  final Function() onTap;
  final PickableItem? child;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: selected ? Colors.white : Colors.white54,
                    width: selected ? 3 : 1),
                borderRadius: BorderRadius.circular(8)),
            child: switch (child) {
              null => null,
              Building(:final blockIndex) => BuildingBlockWidget(blockIndex),
              Normal(:final image) => Image.asset("assets/images/$image.png"),
            },
          ),
        ),
      ),
    );
  }
}
