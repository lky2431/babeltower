import 'package:babeltower/BabelTowerGame.dart';
import 'package:flutter/material.dart';

class CantPickDialog extends StatefulWidget {
  const CantPickDialog(this.isWeight, {required this.game});

  final bool isWeight;
  final BabelTowerGame game;

  @override
  State<CantPickDialog> createState() => _CantPickDialogState();
}

class _CantPickDialogState extends State<CantPickDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      widget.game.overlays.remove(widget.isWeight ? "Overload" : "Overitem");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 64),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.isWeight
                    ? "The weight of bag exceed your limit."
                    : "The number of item in your bag reach the maximum",
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
