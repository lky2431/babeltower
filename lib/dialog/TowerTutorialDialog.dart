import 'package:babeltower/Widgets/BuildingBlockWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';

class TowerTutorialDialog extends StatefulWidget {
  const TowerTutorialDialog(this.context);
  final BuildContext context;

  @override
  State<TowerTutorialDialog> createState() => _TowerTutorialDialogState();
}

class _TowerTutorialDialogState extends State<TowerTutorialDialog> {
  int page = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
              color: Colors.brown, borderRadius: BorderRadius.circular(24)),
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildContent(),
                SizedBox(
                  height: 24,
                ),
                TextButton(
                    onPressed: () {
                      if (page < 3) {
                        setState(() {
                          page = page += 1;
                        });
                      } else {
                        widget.context
                            .read<GlobalBloc>()
                            .add(GlobalEvent.finishTutorial(GameStage.tower));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(page < 3 ? "Next" : "OK"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    switch (page) {
      case 0:
        return [
          Text("It is time to build the tower by the blocks you collected."),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80, width: 80, child: BuildingBlockWidget(0)),
              SizedBox(height: 80, width: 80, child: BuildingBlockWidget(2)),
            ],
          ),
        ];
      case 1:
        return [
          Text(
              "The zone to put the tower is indicated by the green rectangle. You have to fill the tower to have at least 6 layers."),
          SizedBox(
            height: 24,
          ),
          Image.asset("assets/images/sixlayer.png", height: 100),
        ];
      case 2:
        return [
          Text(
              "Drag the block to place the blocks. No block can be hanging in the air. The green block is valid and red block is in invalid block. Release the block to confirm the placement. "),
          Image.asset("assets/images/towerdemo.png", height: 100),
        ];
      case 3:
        return [
          Text(
              "Press the rotate button to rotate the orientation of the block."),
          SizedBox(
            height: 24,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.brown, borderRadius: BorderRadius.circular(8)),
              child:
                  IconButton(onPressed: () {}, icon: Icon(Icons.rotate_left))),
        ];
    }
    return [];
  }
}
