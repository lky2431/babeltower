
import 'package:flame_audio/flame_audio.dart';

FlameInitiate()async{
  await FlameAudio.audioCache.loadAll(['explosion.mp3', 'footstep.mp3','mosquito.mp3','zombie.mp3']);
}