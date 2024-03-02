import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/global/global_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';

enum _WalletState { start, showup }

class GetWalletPage extends StatefulWidget {
  const GetWalletPage({super.key});

  @override
  State<GetWalletPage> createState() => _GetWalletPageState();
}

class _GetWalletPageState extends State<GetWalletPage>
    with TickerProviderStateMixin {
  _WalletState walletState = _WalletState.start;
  List<Widget> balls = [];
  double trashOpacity = 0;
  bool showText = false;

  _startShowUp() {
    setState(() {
      walletState = _WalletState.showup;
    });
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      balls.add(_BallWidget(
        saturation: 1 - timer.tick / 110,
      ));
      setState(() {});
      if (timer.tick == 80) {
        setState(() {
          trashOpacity = 1;
        });
      }
      if (timer.tick == 100) {
        timer.cancel();
        setState(() {
          showText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (walletState == _WalletState.showup) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                AnimatedOpacity(
                    opacity: trashOpacity,
                    duration: Duration(seconds: 1),
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white54),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/block.png"),
                          )),
                    )),
                ...balls
              ],
            ),
          ),
          _ConversationSection(showText)
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("claim your reward"),
          GestureDetector(
              onTap: _startShowUp,
              child: Image.asset("assets/images/add_to_wallet.png")),
        ],
      ),
    );
  }
}

class _ConversationSection extends StatefulWidget {
  const _ConversationSection(this.showText);

  final bool showText;

  @override
  State<_ConversationSection> createState() => _ConversationSectionState();
}

class _ConversationSectionState extends State<_ConversationSection> {
  int stage = 0;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.showText ? 1 : 0,
      child: Column(
        children: [
          if (stage == 0) ..._buildYesNo(),
          if (stage == 1) ..._buildAnswerNo(),
          if (stage == 2) ..._buildFinal()
        ],
      ),
    );
  }

  _getWallet() async {
    String site = "https://getwallet-l42v3m3nxa-uc.a.run.app";
    Dio dio = Dio();

    Response response = await Dio().get(site);
    print(response);
    await launchUrl(Uri.parse(response.data));
    context.read<GlobalBloc>().add(GlobalEvent.quit());
  }

  List<Widget> _buildYesNo() {
    return [
      SizedBox(
        height: 24,
      ),
      Text("Do you want to put this trash into your wallet?"),
      SizedBox(
        height: 12,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _getWallet,
              child: Text("Yes")),
          SizedBox(
            width: 12,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  stage = 1;
                });
              },
              child: Text("No!")),
        ],
      )
    ];
  }

  List<Widget> _buildAnswerNo() {
    return [
      SizedBox(
        height: 24,
      ),
      Text("So why don't you put your trash on earth?"),
      SizedBox(
        height: 12,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _getWallet,
              child: Text("OK, I take it")),
          SizedBox(
            width: 12,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  stage = 2;
                });
              },
              child: Text("No!")),
        ],
      )
    ];
  }

  List<Widget> _buildFinal() {
    return [
      SizedBox(
        height: 24,
      ),
      Text("OK. Please remember reduce waste."),
      SizedBox(
        height: 12,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                context.read<GlobalBloc>().add(GlobalEvent.quit());
              },
              child: Text("OK")),
        ],
      )
    ];
  }
}

class _BallWidget extends StatefulWidget {
  const _BallWidget({required this.saturation});
  final double saturation;

  @override
  State<_BallWidget> createState() => _BallWidgetState();
}

class _BallWidgetState extends State<_BallWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double angle;
  late Color color;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    angle = Random().nextDouble() * 2 * pi;
    _controller.forward();
    color = HSVColor.fromAHSV(
            1, Random().nextInt(360).toDouble(), widget.saturation, 1)
        .toColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: 1 - _controller.value,
              child: Transform.translate(
                offset: Offset(_controller.value * 100 * cos(angle),
                    _controller.value * 100 * sin(angle)),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                ),
              ),
            );
          }),
    );
  }
}
