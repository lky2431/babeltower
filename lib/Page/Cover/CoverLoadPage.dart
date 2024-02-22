import 'package:flutter/material.dart';

import '../../bloc/global/global_bloc.dart';
import '../../model/GameContent.dart';
import '../../repo/HiveRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoverLoadPage extends StatelessWidget {
  const CoverLoadPage({required this.onBack});

  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Select a game",
          style: TextStyle(fontSize: 20),
        ),
        Column(

          children: List.generate(3, (index) {
            GameContent? game = context.read<HiveRepo>().getGame(index);
            return GestureDetector(
              onTap: () {
                if (game != null) {
                  context
                      .read<GlobalBloc>()
                      .add(GlobalEvent.loadGame(game));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (context) {
                        if (game != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "${game.name}",
                                style: TextStyle(fontSize: 24),
                              ),
                              Text("Day ${game.day}",
                                  style: TextStyle(fontSize: 16))
                            ],
                          );
                        }
                        return Center(
                          child: Text(
                            "This is empty",
                            style: TextStyle(fontSize: 36),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        OutlinedButton(onPressed: onBack, child: Text("Back"))
      ],
    );
  }
}
