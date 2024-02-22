import 'dart:math';

import 'package:babeltower/Widgets/BuildingBlockWidget.dart';
import 'package:babeltower/dialog/TowerTutorialDialog.dart';
import 'package:babeltower/dialog/VictoryDialog.dart';
import 'package:babeltower/model/BuildingBlock.dart';
import 'package:confetti/confetti.dart';
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

  final ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 3));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      if (!context
          .read<GlobalBloc>()
          .state
          .gameContent!
          .hintShown[GameStage.tower]!) {
        showDialog(context: context, builder: (_) => TowerTutorialDialog(context));
      }
    });
  }

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
            return Stack(
              children: [
                BlocProvider(
                  create: (context) => TowerBloc(context.read<GlobalBloc>()),
                  child: BlocConsumer<TowerBloc, TowerState>(
                    listenWhen: (prev, current) {
                      return !prev.isFinish && current.isFinish;
                    },
                    builder: (context, towerState) {
                      Map<int, int> blocks = towerState.blocks;
                      return OrientationBuilder(
                          builder: (context, orientation) {
                        if (orientation == Orientation.portrait) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildMainBody(context, towerState),
                              ),
                              _buildGround(width, height),
                              _buildSelection(blocks, height,
                                  towerState.rotation, context, orientation)
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: _buildMainBody(context, towerState),
                                ),
                                _buildGround(width, height),
                              ],
                            )),
                            SizedBox(
                              width: 150,
                              height: height,
                              child: _buildSelection(blocks, height,
                                  towerState.rotation, context, orientation),
                            )
                          ],
                        );
                      });
                    },
                    listener: (BuildContext context, TowerState state) {
                      _controllerCenter.play();
                      Future.delayed(Duration(seconds: 2), () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => VictoryDialog(context));
                      });
                    },
                  ),
                ),
                buildExitButton(context)
              ],
            );
          },
        ),
      ),
    );
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Padding buildExitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.brown, borderRadius: BorderRadius.circular(8)),
        child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: Text("Finish the tower building?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context
                                    .read<GlobalBloc>()
                                    .add(GlobalEvent.dayPass());
                              },
                              child: Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No"))
                        ],
                      ));
            },
            icon: Icon(Icons.exit_to_app)),
      ),
    );
  }

  Widget _buildMainBody(BuildContext context, TowerState towerState) {
    return LayoutBuilder(builder: (context, constraint) {
      double height = constraint.maxHeight;
      double width = constraint.maxWidth;
      return Container(
        width: height / 15 * 5,
        child: Stack(
          children: [
            Container(
              child: DragTarget<int>(
                onAccept: (index) {
                  context.read<TowerBloc>().add(TowerEvent.accept(index));
                },
                onLeave: (index) {
                  context.read<TowerBloc>().add(TowerEvent.cancel());
                },
                onMove: (DragTargetDetails details) {
                  double thresholdx = (width - height / 3) / 2;
                  int column = (details.offset.dx - thresholdx + height / 15) ~/
                      (height / 15);
                  context
                      .read<TowerBloc>()
                      .add(TowerEvent.updatePosition(column, details.data));
                  setState(() {
                    offset = details.offset;
                  });
                },
                builder: (BuildContext context, List<Object?> candidateData,
                    List<dynamic> rejectedData) {
                  return Row(
                    children: List.generate(5, (i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...List.generate(
                              11,
                              (j) => SizedBox(
                                    height: height / 15,
                                    width: height / 15,
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        if (j < towerState.towerBuilt[i]!) {
                                          return Image.asset(
                                              "assets/images/block.png");
                                        }
                                        if ((towerState.valid[i] ?? [])
                                            .contains(j)) {
                                          return Image.asset(
                                            "assets/images/block.png",
                                            color:
                                                Colors.green.withOpacity(0.4),
                                            colorBlendMode: BlendMode.color,
                                          );
                                        }
                                        if ((towerState.notvalid[i] ?? [])
                                            .contains(j)) {
                                          return Image.asset(
                                            "assets/images/block.png",
                                            color: Colors.red.withOpacity(0.4),
                                            colorBlendMode: BlendMode.color,
                                          );
                                        }

                                        return Container();
                                      },
                                    ),
                                  )).reversed,
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
                    border: Border.all(color: Colors.green, width: 3),
                  ),
                  width: height / 15 * 5,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                emissionFrequency: 0.15,
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSelection(Map<int, int> blocks, double height, int rotation,
      BuildContext context, Orientation orientation) {
    return Container(
      color: Colors.black,
      child: Builder(builder: (context) {
        if (orientation == Orientation.portrait) {
          return Row(
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
                        child: _blockOption(index, height, rotation, blocks),
                      );
                    }),
                  ),
                ),
              ),
              buildRotateButton(context)
            ],
          );
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(availableBlocks.length, (index) {
                    if (blocks[index] == null || blocks[index] == 0) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8),
                      child: _blockOption(index, height, rotation, blocks),
                    );
                  }),
                ),
              ),
            ),
            buildRotateButton(context)
          ],
        );
      }),
    );
  }

  Draggable<int> _blockOption(
      int index, double height, int rotation, Map<int, int> blocks) {
    return Draggable(
      data: index,
      feedback: Opacity(
        opacity: 0.5,
        child: SizedBox(
            height: height / 5,
            width: height / 5,
            child: BuildingBlockWidget(index, rotation: rotation)),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white30)),
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
                      shape: BoxShape.circle, color: Colors.brown),
                  child: Center(child: Text("${blocks[index]}")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildRotateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.brown, borderRadius: BorderRadius.circular(8)),
          child: IconButton(
              onPressed: () {
                context.read<TowerBloc>().add(TowerEvent.rotate());
              },
              icon: Icon(Icons.rotate_left))),
    );
  }

  Widget _buildGround(double width, double height) {
    return LayoutBuilder(builder: (context, constraint) {
      double width = constraint.maxWidth;
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
    });
  }
}
