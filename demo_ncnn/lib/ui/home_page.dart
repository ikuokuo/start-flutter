import 'package:easy_debounce/easy_debounce.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../store/stores.dart';
import 'detect_result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageStore _imageStore;
  late YoloxStore _yoloxStore;
  late OptionStore _optionStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _imageStore = Provider.of<ImageStore>(context);
    _yoloxStore = Provider.of<YoloxStore>(context);
    _optionStore = Provider.of<OptionStore>(context);

    _imageStore.load();

    super.didChangeDependencies();
  }

  void _debounce(String tag, void Function() onExecute,
      {Duration duration = const Duration(milliseconds: 200)}) {
    EasyDebounce.debounce(tag, duration, onExecute);
  }

  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    final image = result.files.first;
    _openImage(image);
  }

  void _openImage(PlatformFile file) {
    _imageStore.load(imagePath: file.path);
  }

  void _detectImage() {
    if (_imageStore.loadFuture.futureState != FutureState.loaded) return;
    _yoloxStore.detect(_imageStore.loadFuture.data!);
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
                child: Observer(builder: (context) {
                  if (_imageStore.loadFuture.futureState ==
                      FutureState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_imageStore.loadFuture.errorMessage != null) {
                    return Center(
                        child: Text(_imageStore.loadFuture.errorMessage!));
                  }

                  final data = _imageStore.loadFuture.data;
                  if (data == null) {
                    return const Center(child: Text('Image load null :('));
                  }

                  _yoloxStore.detectFuture.reset();

                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orangeAccent)),
                    child: DetectResultPage(imageData: data),
                  );
                })),
            const SizedBox(height: pad),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Pick image'),
                    onPressed: () => _debounce('_pickImage', _pickImage),
                  ),
                ),
                const SizedBox(width: pad),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Detect objects'),
                    onPressed: () => _debounce('_detectImage', _detectImage),
                  ),
                ),
                const SizedBox(width: pad),
                Expanded(
                  child: Observer(builder: (context) {
                    return ElevatedButton.icon(
                      icon: Icon(_optionStore.bboxesVisible
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank),
                      label: const Text('Binding boxes'),
                      onPressed: () => _optionStore
                          .setBboxesVisible(!_optionStore.bboxesVisible),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
