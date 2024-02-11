import 'package:babeltower/BabelTowerGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/player/player_bloc.dart';

class HealthBarWidget extends StatelessWidget {
  const HealthBarWidget(this.game);

  final BabelTowerGame game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraint) {
              double width = constraint.maxWidth;
              if (width > 500) {
                width = 500;
              }
              return Stack(
                alignment: Alignment.centerRight,
                children: [
                  Image.asset(
                    "assets/images/health_background.png",
                    width: width,
                    fit: BoxFit.fitWidth,
                  ),
                  BlocBuilder<PlayerBloc, PlayerState>(
                    builder: (context, state) {
                      return ClipRect(
                        clipper: cCliper(width, state.health),
                        child: Image.asset(
                          "assets/images/health_bar.png",
                          width: width,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                  )
                ],
              );
            }),
          ),
          IconButton(
              onPressed: () {
                game.pauseEngine();
                game.overlays.add("Bag");
              },
              icon: Icon(Icons.work))
        ],
      ),
    );
  }
}

class cCliper extends CustomClipper<Rect> {
  cCliper(this.width, this.ratio);
  final double width;
  final double ratio;
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(30 * width / 256, 0, width * 220 / 256 * ratio, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
