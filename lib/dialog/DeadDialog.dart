import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeadDialog extends StatefulWidget {
  const DeadDialog({super.key});

  @override
  State<DeadDialog> createState() => _DeadDialogState();
}

class _DeadDialogState extends State<DeadDialog> {
  double opacity = 0.1;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacity = 0.9;
      });
    });
    Future.delayed(Duration(milliseconds: 1800), () {
      setState(() {
        showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 1500),
      child: Container(
        color: Colors.red,
        child: SizedBox.expand(
          child: showText
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You are dead",
                      style: TextStyle(fontSize: 36),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                        onPressed: () {
                          context.read<GlobalBloc>().add(GlobalEvent.quit());
                        },
                        child: Text("Quit"))
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
