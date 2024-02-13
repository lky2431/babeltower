import 'package:babeltower/BabelTowerGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeaveFieldDialog extends StatefulWidget {
  const LeaveFieldDialog(this.game);
  final BabelTowerGame game;

  @override
  State<LeaveFieldDialog> createState() => _LeaveFieldDialogState();
}

class _LeaveFieldDialogState extends State<LeaveFieldDialog> {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AlertDialog(
            content: Text("Do you want to leave the mountain now?"),
            actions: [
              TextButton(
                  onPressed: () {
                    widget.game.overlays.remove("Leave");
                    widget.game.overlays.add("Summary");
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    widget.game.overlays.remove("Leave");
                    widget.game.resumeEngine();
                  },
                  child: Text("No"))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
