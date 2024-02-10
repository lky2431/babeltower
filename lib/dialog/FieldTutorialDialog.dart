import 'package:babeltower/BabelTowerGame.dart';
import 'package:flutter/material.dart';

class FieldTutorialDialog extends StatefulWidget {
  const FieldTutorialDialog(this.game);

  final BabelTowerGame game;

  @override
  State<FieldTutorialDialog> createState() => _FieldTutorialDialogState();
}

class _FieldTutorialDialogState extends State<FieldTutorialDialog> {
  @override
  void initState() {
    super.initState();
    widget.game.pauseEngine();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.brown
          ),
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Welcome to garbage mountain. You have to search the building block in here to build the tower. You can also collect something sell to earn some money. Stay away from the threat that will reduce your life. Go back to the start position to go back home. Your speed will be slower if you carried too much stuff."),
                TextButton(
                    onPressed: () {

                      widget.game.resumeEngine();
                      widget.game.overlays.remove("Tutorial");

                    },
                    child: Text("OK"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
