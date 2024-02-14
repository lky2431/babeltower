import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:babeltower/repo/HiveRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoverSavePage extends StatelessWidget {
  const CoverSavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Select a save position",
          style: TextStyle(fontSize: 20),
        ),
        ...List.generate(3, (index) {
          GameContent? game = context.read<HiveRepo>().getGame(index);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                if (game != null) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            content: Text("Do you want to cover this record?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context.read<GlobalBloc>().add(
                                        GlobalEvent.setSavePosition(index));
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                            ],
                          ));
                } else {
                  context
                      .read<GlobalBloc>()
                      .add(GlobalEvent.setSavePosition(index));
                }
              },
              child: Container(
                height: 100,
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
        })
      ],
    );
  }
}
