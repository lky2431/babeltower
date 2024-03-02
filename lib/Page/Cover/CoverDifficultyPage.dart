import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global/global_bloc.dart';

class CoverDifficultyPage extends StatefulWidget {
  const CoverDifficultyPage({required this.onConfirm, required this.onBack});
  final Function() onConfirm;
  final Function() onBack;

  @override
  State<CoverDifficultyPage> createState() => _CoverDifficultyPageState();
}

class _CoverDifficultyPageState extends State<CoverDifficultyPage> {
  Difficulty difficulty = Difficulty.real;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        widget.onBack();
      },
      child: FadeIn(
        child: Center(
          child: SizedBox(
            height: 400,
            child: LayoutBuilder(builder: (context, constraint) {
              double height = constraint.maxHeight;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(() {
                    setState(() {
                      difficulty = Difficulty.simple;
                    });
                  }, difficulty == Difficulty.simple, "Simple", height / 6),
                  _buildButton(() {
                    setState(() {
                      difficulty = Difficulty.real;
                    });
                  }, difficulty == Difficulty.real, "Real", height / 6),
                  _buildButton(() {
                    setState(() {
                      difficulty = Difficulty.tough;
                    });
                  }, difficulty == Difficulty.tough, "Tough", height / 6),
                  SizedBox(height:height/8,child: _buildDescription()),
                  SizedBox(
                    height: height/8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<GlobalBloc>()
                                .add(GlobalEvent.difficulty(difficulty));
                            widget.onConfirm();
                          },
                          child: AutoSizeText(
                            "CONFIRM",
                            style: TextStyle(fontSize: 24),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height/10,
                    child: TextButton(
                        onPressed: () {
                          widget.onBack();
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 60,
        child: Center(
          child: Text(
            _buildContent(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  String _buildContent() {
    switch (difficulty) {
      case Difficulty.simple:
        return "choose this if you want to experiencce the story";
      case Difficulty.real:
        return "just like a real life";
      case Difficulty.tough:
        return "life is tough. Right?";
    }
  }

  _buildButton(Function() onTap, bool selected, String label, double height) {
    return SizedBox(
      height: height,
      width: 250,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.white.withOpacity(selected ? 1 : 0.6)),
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: AutoSizeText(
                  label,
                  style: TextStyle(
                      fontFamily: "Destroy",
                      fontSize: 28,
                      color: Colors.white.withOpacity(selected ? 1 : 0.6)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
