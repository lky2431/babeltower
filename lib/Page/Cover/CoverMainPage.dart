import 'package:flutter/material.dart';

class CoverMainPage extends StatelessWidget {
  const CoverMainPage({required this.onNewGame});

  final Function() onNewGame;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Babel Tower",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Destroy", fontSize: 64, color: Colors.white),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: onNewGame,
                    child: Text(
                      "New Game",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    )),
                SizedBox(
                  height: 24,
                ),
                /*TextButton(
                        onPressed: () {},
                        child: Text(
                          "Load Game",
                          style: TextStyle(color: Colors.white, fontSize: 36),
                        )),*/
              ],
            ))
      ],
    );
  }
}
