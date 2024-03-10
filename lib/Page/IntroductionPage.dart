import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  int stage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (stage >= 18) {
          context
              .read<GlobalBloc>()
              .add(GlobalEvent.changeStage(GameStage.day));
          return;
        }
        setState(() {
          stage = stage + 1;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/home.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildStage(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStage() {
    switch (stage) {
      case 0:
        return _buildContent(job, "I am back");
      case 1:
        return _buildContent(wife, "How much you earnt today?");
      case 2:
        return _buildContent(job, "...");
      case 3:
        return _buildContent(wife,
            "We can't keep living like this. We have no food. Our children are suffering");
      case 4:
        return _buildContent(
            job, "I know. I have tried so hard but there is no job now.");
      case 5:
        return _buildContent(
            wife, "That's not good enough! You should find some money.");
      case 6:
        return _buildContent(
            job, "I said I known. Can you just leave me a quiet place.");
      case 7:
        return _buildContent(wife, "...");
      case 8:
        return _buildContent(rich, "Hello, man");
      case 9:
        return _buildContent(job, "Sir, are you speaking to me?");
      case 10:
        return _buildContent(rich,
            "Yes. You look like a hard worker. Are you looking for a job?");
      case 11:
        return _buildContent(job, "Yes! I can do anything for you.");
      case 12:
        return _buildContent(rich,
            "Great. I have a project. I need some hard working people to help me.");
      case 13:
        return _buildContent(rich,
            "I want to build a tower in here. If you can finish the tower. I will pay you \$10");
      case 14:
        return _buildContent(
            job, "Sure. Where can I find the material to build the tower?");
      case 15:
        return _buildContent(rich,
            "No worry. I will put the building block in the garbage mountain everyday. You can collect them everyday.");
      case 16:
        return _buildContent(job, "OK. I will do this job well.");
      case 17:
        return _buildContent(
            job, "( May I can find some good stuff to sell on the way )");
      case 18:
        return _buildContent(
            rich, "Great. I am looking forward to see the tower soon.");
      default:
        return [];
    }
  }

  String get job => "job";
  String get wife => "wife";
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
        alignment: (image == wife || image == rich)
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Image.asset(
          "assets/images/$image.png",
          height: MediaQuery.of(context).size.height*0.35,
          fit: BoxFit.fill,
        ),
      )
    ];
  }
}
