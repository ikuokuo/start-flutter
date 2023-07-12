import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../store/stores.dart';
import '../util/image.dart';

import 'detect_result_painter.dart';

class DetectResultPage extends StatefulWidget {
  const DetectResultPage({super.key, required this.imageData});

  final ImageData imageData;

  @override
  State<DetectResultPage> createState() => _DetectResultPageState();
}

class _DetectResultPageState extends State<DetectResultPage> {
  late YoloxStore _yoloxStore;
  late OptionStore _optionStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _yoloxStore = Provider.of<YoloxStore>(context);
    _optionStore = Provider.of<OptionStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.imageData;

    final painter = DetectResultPainter();
    painter.setImageSize(
        Size(data.image.width.toDouble(), data.image.height.toDouble()));

    return Stack(alignment: Alignment.center, children: [
      Observer(builder: (context) {
        if (_optionStore.bboxesVisible) {
          final result = _yoloxStore.detectFuture.data;
          painter.setObjects(result?.objects);
        } else {
          painter.setObjects(null);
        }
        return CustomPaint(
          foregroundPainter: painter,
          child: RawImage(image: data.imageUi),
        );
      }),
      Positioned(
          left: 0,
          top: 0,
          child: Observer(builder: (context) {
            final data = widget.imageData;
            var message = '${data.imagePath}'
                '\nsize: ${data.image.width}x${data.image.height}'
                '\nloadTime: ${(data.loadTime.inMicroseconds * 0.001).toStringAsFixed(2)} ms';

            if (_yoloxStore.detectFuture.futureState == FutureState.initial) {
            } else if (_yoloxStore.detectFuture.futureState ==
                FutureState.loading) {
              message += '\ndetect ...';
            } else {
              if (_yoloxStore.detectFuture.errorMessage != null) {
                message +=
                    '\ndetect error: ${_yoloxStore.detectFuture.errorMessage}';
              } else {
                final result = _yoloxStore.detectFuture.data;
                if (result == null) {
                  message += '\ndetect fail :(';
                } else {
                  message += '\ndetect success!'
                      '\n  time: ${(result.detectTime.inMicroseconds * 0.001).toStringAsFixed(2)} ms'
                      '\n  objs: ${result.objects.length}';
                }
              }
            }

            return Text(message,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize:
                        Theme.of(context).textTheme.labelLarge?.fontSize));
          })),
    ]);
  }
}
