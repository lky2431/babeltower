import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/Widgets/BuildingBlockWidget.dart';
import 'package:flutter/material.dart';

class FieldTutorialDialog extends StatefulWidget {
  const FieldTutorialDialog(this.game);

  final BabelTowerGame game;

  @override
  State<FieldTutorialDialog> createState() => _FieldTutorialDialogState();
}

class _FieldTutorialDialogState extends State<FieldTutorialDialog> {
  int page = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      widget.game.pauseEngine();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        widget.game.resumeEngine();
                        widget.game.overlays.remove("Tutorial");
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
          Text(
              "Welecome to garbage mountain. Your primary goal is to find the buidling block place in the mountain. You can drag the monitor or use keyboard to control the character movement."),
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
              "You have so many threat around you. Stay away from them. They will decrease your health when you touch them."),
        ];
      case 2:
        return [
          Text(
              "There is some good stuff on the ground that you can collect to sell for your family expense or buying something. However, the more thing you carried, the slower you move")
        ];
      case 3:
        return [Text("Go back to the portal when you finish.")];
    }
    return [];
  }
}
