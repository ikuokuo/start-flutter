import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:window_size/window_size.dart';

import 'ui/detect_result_page.dart';

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
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowMinSize(const Size(windowWidth, windowHeight));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YoloX Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'YoloX Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showBboxes = true;
  String? _imagePath;

  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    final image = result.files.first;
    _openImage(image);
  }

  void _openImage(PlatformFile file) {
    setState(() {
      _imagePath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    const pad = 20.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(pad),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent)),
                child: DetectResultPage(imagePath: _imagePath),
              ),
            ),
            const SizedBox(height: pad),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Pick image'),
                    onPressed: () => _pickImage(),
                  ),
                ),
                const SizedBox(width: pad),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Detect objects'),
                    onPressed: () => {},
                  ),
                ),
                const SizedBox(width: pad),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(_showBboxes
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank),
                    label: const Text('Binding boxes'),
                    onPressed: () => setState(() {
                      _showBboxes = !_showBboxes;
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
