import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';

class EndingPage extends StatefulWidget {
  const EndingPage({super.key});

  @override
  State<EndingPage> createState() => _EndingPageState();
}

class _EndingPageState extends State<EndingPage> {
  bool reach = false;
  AudioPlayer player = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    player.stop();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!reach) {
      return OfficeZone(onOfficeFinish: () async {
        await player.play(AssetSource("audio/allegro.mp3"));
        setState(() {
          reach = true;
        });
      });
    }
    return MessageZone();
  }
}

class MessageZone extends StatefulWidget {
  const MessageZone({super.key});

  @override
  State<MessageZone> createState() => _MessageZoneState();
}

class _MessageZoneState extends State<MessageZone>
    with TickerProviderStateMixin {
  late final AnimationController _backgroundOpacityController;
  late final AnimationController _backgroundSizeController;
  late final AnimationController _textOpacityController;

  int stage = 0;
  final double aspectratio = 640 / 427;
  bool ready = false;

  @override
  void initState() {
    _backgroundOpacityController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _backgroundSizeController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _textOpacityController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _playAnimation();

    super.initState();
  }

  _playAnimation() {
    _backgroundOpacityController.stop();
    _backgroundSizeController.value = 0;
    _backgroundSizeController.forward();
    _backgroundOpacityController.value = 0;
    _backgroundOpacityController.forward();
    _textOpacityController.value = 0;
    Future.delayed(Duration(seconds: 1), () {
      _textOpacityController.forward();
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        ready = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenAspect = MediaQuery.of(context).size.aspectRatio;

    return GestureDetector(
      onTap: () {
        if (!ready) {
          return;
        }
        if (stage < 4) {
          ready = false;
          setState(() {
            stage = stage + 1;
          });
          _playAnimation();
        } else {
          context
              .read<GlobalBloc>()
              .add(GlobalEvent.changeStage(GameStage.wallet));
        }
      },
      child: Stack(
        children: [
          if (stage < 4)
            AnimatedBuilder(
                animation: _backgroundSizeController,
                builder: (context, animation) {
                  return Transform.scale(
                    scale: 1 + 0.2 * _backgroundSizeController.value,
                    child: SizedBox.expand(
                      child: AnimatedBuilder(
                          animation: _backgroundOpacityController,
                          builder: (context, animation) {
                            return Opacity(
                              opacity: _backgroundOpacityController.value,
                              child: Image.asset(
                                "assets/images/${_imagename()}.jpg",
                                fit: aspectratio > screenAspect
                                    ? BoxFit.fitHeight
                                    : BoxFit.fitWidth,
                                color: Colors.black38,
                                colorBlendMode: BlendMode.darken,
                              ),
                            );
                          }),
                    ),
                  );
                }),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  constraints: BoxConstraints(maxWidth: 500),
                  child: SizedBox.expand(
                    child: Center(
                      child: AnimatedBuilder(
                          animation: _textOpacityController,
                          builder: (context, animation) {
                            return Opacity(
                              opacity: _textOpacityController.value,
                              child: Text(
                                _buildMessage(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          }),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  String _imagename() {
    switch (stage) {
      case 0:
        return "shipping";
      case 1:
        return "pollution";
      case 2:
        return "suffer";
      case 3:
        return "lesswaste";
      default:
        return "";
    }
  }

  String _buildMessage() {
    switch (stage) {
      case 0:
        return "Garbage is often shipped to developing countries for disposal everyday";
      case 1:
        return "Contributing to environmental and health problems for local communities";
      case 2:
        return "The people living in these communities are struggling to survive.";
      case 3:
        return "Stop waste trade!\nReduce your waste!";
      case 4:
        return "The end";
      default:
        return "";
    }
  }
}

class OfficeZone extends StatefulWidget {
  const OfficeZone({required this.onOfficeFinish});
  final Function() onOfficeFinish;

  @override
  State<OfficeZone> createState() => _OfficeZoneState();
}

class _OfficeZoneState extends State<OfficeZone> {
  int stage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (stage < 4) {
          setState(() {
            stage = stage + 1;
          });
        } else {
          widget.onOfficeFinish();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/office.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Builder(builder: (context) {
          return SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildStage(context),
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildStage(BuildContext context) {
    switch (stage) {
      case 0:
        return _buildContent(boy,
            "Hello ${context.read<GlobalBloc>().state.gameContent!.name!}");
      case 1:
        return _buildContent(rich, "Hi, how are you doing?");
      case 2:
        return _buildContent(boy,
            "I would like to report that our previous place to ship the garbage is saturated.");
      case 3:
        return _buildContent(
            rich, "It is ok. Let find another place to ship our garbage.");
      case 4:
        return _buildContent(rich,
            "Just give them \$10 dollar and ask them to build a tower. The people will handle all garbage we shipped.");
      default:
        return [];
    }
  }

  String get boy => "officeboy";
  String get rich => "richman";

  List<Widget> _buildContent(String image, String content) {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white60)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                content,
                style: TextStyle(fontSize: 24),
              ),
            )),
      ),
      SizedBox(
        height: 36,
      ),
      Align(
        alignment:
            (image == boy) ? Alignment.centerRight : Alignment.centerLeft,
        child: Image.asset(
          "assets/images/$image.png",
          scale: 0.3,
        ),
      )
    ];
  }
}
