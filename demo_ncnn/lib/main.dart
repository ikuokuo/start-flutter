import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:window_size/window_size.dart';

import 'ui/app.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    // ignore: avoid_print
    print('${rec.loggerName} ${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  setupWindow();

  runApp(const MyApp());
}

const double windowWidth = 800;
const double windowHeight = 600;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('YoloX Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    // setWindowMaxSize(const Size(windowWidth, windowHeight));
    // getCurrentScreen().then((screen) {
    //   setWindowFrame(Rect.fromCenter(
    //     center: screen!.frame.center,
    //     width: windowWidth,
    //     height: windowHeight,
    //   ));
    // });
  }
}
