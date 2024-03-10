import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoverMainPage extends StatelessWidget {
  const CoverMainPage(
      {required this.onNewGame,
      required this.onLoadGame,
      required this.onDownload});

  final Function() onNewGame;
  final Function() onLoadGame;
  final Function() onDownload;

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
                FadeIn(
                  child: TextButton(
                      onPressed: onNewGame,
                      child: Text(
                        "New Game",
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      )),
                ),
                SizedBox(
                  height: 24,
                ),
                FadeIn(
                  child: TextButton(
                      onPressed: onLoadGame,
                      child: Text(
                        "Load Game",
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      )),
                ),
                if (kIsWeb) ...[
                  SizedBox(
                    height: 24,
                  ),
                  FadeIn(
                    child: TextButton(
                        onPressed: onDownload,
                        child: Text(
                          "Download Client",
                          style: TextStyle(color: Colors.white, fontSize: 36),
                        )),
                  )
                ]
              ],
            ))
      ],
    );
  }
}
