import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoverNamePage extends StatefulWidget {
  const CoverNamePage({required this.onConfirm, required this.onBack});

  final Function() onConfirm;
  final Function() onBack;

  @override
  State<CoverNamePage> createState() => _CoverNamePageState();
}

class _CoverNamePageState extends State<CoverNamePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        widget.onBack();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "input your name",
            style: TextStyle(color: Colors.white, fontSize: 36),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3)),
                ),
              )),
          TextButton(
              onPressed: () {
                if (_controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please input a name")));
                  return;
                }
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Your name is ${_controller.text}"),
                          content: Text("You cannot edit this in the future"),
                          actions: [
                            TextButton(onPressed: () {
                              widget.onConfirm();
                              Navigator.of(context).pop();
                              context.read<GlobalBloc>().add(GlobalEvent.name(_controller.text));
                            }, child: Text("OK")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"))
                          ],
                        ));
              },
              child: Text("CONFIRM", style: TextStyle(fontSize: 28))),
          SizedBox(
            height: 180,
          ),
          TextButton(
              onPressed: widget.onBack,
              child: Text("BACK", style: TextStyle(fontSize: 28))),
        ],
      ),
    );
  }
}
