import 'package:babeltower/model/GameContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global/global_bloc.dart';

class CoverDifficultyPage extends StatefulWidget {
  const CoverDifficultyPage({required this.onConfirm});
  final Function() onConfirm;

  @override
  State<CoverDifficultyPage> createState() => _CoverDifficultyPageState();
}

class _CoverDifficultyPageState extends State<CoverDifficultyPage> {
  Difficulty difficulty = Difficulty.real;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(() {
          setState(() {
            difficulty = Difficulty.simple;
          });
        }, difficulty == Difficulty.simple, "Simple"),
        _buildButton(() {
          setState(() {
            difficulty = Difficulty.real;
          });
        }, difficulty == Difficulty.real, "Real"),
        _buildButton(() {
          setState(() {
            difficulty = Difficulty.tough;
          });
        }, difficulty == Difficulty.tough, "Tough"),
        _buildDescription(),
        TextButton(
            onPressed: () {
              context
                  .read<GlobalBloc>()
                  .add(GlobalEvent.difficulty(difficulty));
              widget.onConfirm();
            },
            child: Text(
              "CONFIRM",
              style: TextStyle(fontSize: 24),
            ))
      ],
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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

  _buildButton(Function() onTap, bool selected, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: Colors.white.withOpacity(selected ? 1 : 0.6)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
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
    );
  }
}
