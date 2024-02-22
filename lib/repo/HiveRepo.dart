import 'package:babeltower/bloc/global/global_bloc.dart';
import 'package:babeltower/model/GameContent.dart';
import 'package:babeltower/model/Goods.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveRepo {
  HiveRepo();

  var box;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GameContentImplAdapter());
    Hive.registerAdapter(DifficultyAdapter());
    Hive.registerAdapter(GameStageAdapter());
    Hive.registerAdapter(allGoodsAdapter());
    box = await Hive.openBox<GameContent>('Game');
  }

  GameContent? getGame(int index){
    return box.get(index.toString());
  }

  saveGame(int index, GameContent game){
    box.put(index.toString(), game);
  }
}
