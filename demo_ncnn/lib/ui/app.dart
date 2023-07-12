import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../store/stores.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImageStore>(create: (_) => ImageStore()),
        Provider<YoloxStore>(create: (_) => YoloxStore()),
        Provider<OptionStore>(create: (_) => OptionStore()),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            title: 'YoloX Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
              useMaterial3: true,
            ),
            home: const HomePage(title: 'YoloX Demo'),
          );
        },
      ),
    );
  }
}
