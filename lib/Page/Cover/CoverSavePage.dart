import 'package:auto_size_text/auto_size_text.dart';
import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:babeltower/repo/HiveRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoverSavePage extends StatelessWidget {
  const CoverSavePage({required this.onBack});
  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result){
        onBack();
      },
      child: Center(
        child: SizedBox(
          height: 400,
          child: LayoutBuilder(
            builder: (context,constraint) {
              double height = constraint.maxHeight;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height/10,
                    child: AutoSizeText(
                      "Select a save position",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ...List.generate(3, (index) {
                    GameContent? game = context.read<HiveRepo>().getGame(index);
                    return SizedBox(
                      height: height/6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                            constraints: BoxConstraints(maxWidth: 500),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Builder(
                                builder: (context) {
                                  if (game != null) {
                                    return LayoutBuilder(
                                      builder: (context, constraint) {
                                        double subheight = constraint.maxHeight;
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            SizedBox(
                                              height: subheight*0.6,
                                              child: AutoSizeText(
                                                "${game.name}",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            ),
                                            SizedBox(
                                              height: subheight*0.4,
                                              child: AutoSizeText("Day ${game.day}",
                                                  style: TextStyle(fontSize: 16)),
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  }
                                  return Center(
                                    child: AutoSizeText(
                                      "This is empty",
                                      style: TextStyle(fontSize: 36),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height:height/8,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(onPressed: onBack, child: Text("Back")),
                  ))
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
