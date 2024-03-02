import 'package:babeltower/repo/HiveRepo.dart';
import 'package:babeltower/tool/initiate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_appstore_screenshot/simple_appstore_screenshot.dart';

import 'Page/MainPage.dart';
import 'bloc/global/global_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  FlameInitiate();
  HiveRepo hive = HiveRepo();
  hive.init();
  runApp(MaterialApp(
    theme: ThemeData(
        colorSchemeSeed: Colors.brown,
        brightness: Brightness.dark,
        fontFamily: "Pixel",
        textTheme: TextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.white))),
    home: RepositoryProvider(
      create: (context) => hive,
      child: BlocProvider(
          create: (BuildContext context) =>
              GlobalBloc(hive: context.read<HiveRepo>()),
          child: Scaffold(
              body: SimpleScreenShot(
                  callback: (Uint8List? image) async {
                    await Share.shareXFiles([
                      XFile.fromData(image!, name: "image.png", mimeType: "png")
                    ]);
                  },
                  active: false,

                  child: MainPage()))),
    ),
  ));
}
