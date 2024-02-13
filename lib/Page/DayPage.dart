import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        show = true;
      });
    });
    Future.delayed(Duration(milliseconds: 2500), () {
      context.read<GlobalBloc>().add(GlobalEvent.changeStage(GameStage.field));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/grey_sky.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
      ),
      child: show
          ? Center(
              child: BlocBuilder<GlobalBloc, GlobalState>(
                builder: (context, state) {
                  return Text(
                    "Day ${state.gameContent!.day}",
                    style: TextStyle(
                        fontSize: 52,
                        fontFamily: "Destroy",
                        color: Colors.white),
                  );
                },
              ),
            )
          : null,
    );
  }
}
