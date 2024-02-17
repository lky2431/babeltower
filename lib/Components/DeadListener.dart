import 'package:babeltower/BabelTowerGame.dart';
import 'package:babeltower/bloc/player/player_bloc.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

class DeadListener extends Component
    with
        FlameBlocListenable<GameBloc, GameState>,
        HasGameRef<BabelTowerGame> {
  DeadListener();

  @override
  void onNewState(GameState state) {
    super.onNewState(state);
    if (state.health < 0) {
      gameRef.pauseEngine();
      gameRef.overlays.add("Dead");
    }
  }
}
