import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../bloc/player_bloc.dart';

class CustomCamera extends CameraComponent {
  CustomCamera(this.cworld);
  final World cworld;


  @override
  Future<void> onLoad() async {
    world = cworld;
    super.onLoad();

    /*add(FlameBlocListener<PlayerBloc, PlayerState>(onNewState: (state) {

    }));*/
  }



  @override
  void update(double dt) {
    super.update(dt);
  }
}
