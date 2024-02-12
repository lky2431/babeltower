import 'dart:math';

import 'package:babeltower/Widgets/BuildingBlockWidget.dart';
import 'package:babeltower/model/BuildingBlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/tower/tower_bloc.dart';

class BuildTowerPage extends StatefulWidget {
  const BuildTowerPage({super.key});

  @override
  State<BuildTowerPage> createState() => _BuildTowerPageState();
}

class _BuildTowerPageState extends State<BuildTowerPage> {
  int? selectedBlockIndex;

  Offset offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/grey_sky.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox.expand(
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            Map<int, int> blocks = state.gameContent!.blocks;
            return BlocProvider(
              create: (context) => TowerBloc(state.gameContent!.builtTower),
              child: Stack(
                children: [
                  BlocBuilder<TowerBloc, TowerState>(
                    builder: (context, towerState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: height / 15 * 5,
                              child: Stack(
                                children: [
                                  Container(
                                    child: DragTarget<int>(
                                      onAccept: (index) {
                                        context
                                            .read<TowerBloc>()
                                            .add(TowerEvent.leave());
                                      },
                                      onLeave: (index) {
                                        context
                                            .read<TowerBloc>()
                                            .add(TowerEvent.leave());
                                      },
                                      onMove: (DragTargetDetails details) {
                                        double thresholdx =
                                            (width - height / 3) / 2;
                                        int column =
                                            ((details.offset.dx - thresholdx) /
                                                    (height / 15))
                                                .toInt();
                                        context.read<TowerBloc>().add(
                                            TowerEvent.updatePosition(
                                                column, details.data));
                                        setState(() {
                                          offset = details.offset;
                                        });
                                      },
                                      builder: (BuildContext context,
                                          List<Object?> candidateData,
                                          List<dynamic> rejectedData) {
                                        return Row(
                                          children: List.generate(5, (i) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ...List.generate(
                                                    (towerState.valid[i] ?? [])
                                                        .length,
                                                    (j) => SizedBox(
                                                          height: height / 15,
                                                          width: height / 15,
                                                          child: Image.asset(
                                                            "assets/images/block.png",
                                                            color: Colors.green
                                                                .withOpacity(
                                                                    0.4),
                                                            colorBlendMode:
                                                                BlendMode.color,
                                                          ),
                                                        )),
                                                ...List.generate(
                                                    (towerState.valid[i] ??
                                                                [
                                                                  state
                                                                      .gameContent!
                                                                      .builtTower[i]!
                                                                ])
                                                            .reduce(min) -
                                                        state.gameContent!
                                                            .builtTower[i]!,
                                                    (index) => SizedBox(
                                                          height: height / 15,
                                                          width: height / 15,
                                                        )),
                                                ...List.generate(
                                                    state.gameContent!
                                                        .builtTower[i]!,
                                                    (j) => SizedBox(
                                                          height: height / 15,
                                                          width: height / 15,
                                                          child: Image.asset(
                                                              "assets/images/block.png"),
                                                        )),
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                  IgnorePointer(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: height / 15 * 6,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.green, width: 3),
                                        ),
                                        width: height / 15 * 5,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          _buildGround(width, height),
                          _buildSelection(
                              blocks, height, towerState.rotation, context)
                        ],
                      );
                    },
                  ),
                  Positioned(
                      left: offset.dx,
                      top: offset.dy,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: Colors.red),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelection(
      Map<int, int> blocks, double height, int rotation, BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(availableBlocks.length, (index) {
                  if (blocks[index] == null || blocks[index] == 0) {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Draggable(
                      data: index,
                      feedback: Opacity(
                        opacity: 0.5,
                        child: SizedBox(
                            height: height / 5,
                            width: height / 5,
                            child:
                                BuildingBlockWidget(index, rotation: rotation)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: BuildingBlockWidget(
                                  index,
                                  rotation: rotation,
                                ),
                              ),
                              Positioned(
                                right: 4,
                                bottom: 4,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.brown),
                                  child:
                                      Center(child: Text("${blocks[index]}")),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                    onPressed: () {
                      context.read<TowerBloc>().add(TowerEvent.rotate());
                    },
                    icon: Icon(Icons.rotate_left))),
          )
        ],
      ),
    );
  }

  Widget _buildGround(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          (width / (height / 15)).ceil(),
          (index) => SizedBox(
                width: width / ((width / (height / 15)).ceil()),
                height: height / 15,
                child: Image.asset(
                  "assets/images/soil.png",
                  fit: BoxFit.fill,
                ),
              )),
    );
  }
}
