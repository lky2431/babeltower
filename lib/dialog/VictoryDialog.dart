import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';

class VictoryDialog extends StatelessWidget {
  const VictoryDialog(this.context);
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Dialog(
      insetAnimationDuration: Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Congratulation!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 36,
            ),
            Text("You have built the tower"),
            SizedBox(
              height: 24,
            ),
            Text(
              "The biggest achievement in your life.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 36,
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<GlobalBloc>()
                      .add(GlobalEvent.changeStage(GameStage.ending));
                  Navigator.of(context).pop();
                },
                child: Text("Get your reward"))
          ],
        ),
      ),
    );
  }
}
