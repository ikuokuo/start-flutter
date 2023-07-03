import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'detect_result_painter.dart';

class DetectResultPage extends StatelessWidget {
  const DetectResultPage({super.key, required this.imagePath});

  final String? imagePath;
  final String imageAssertDefault = 'assets/dog.jpg';

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> imageProvider;
    if (imagePath == null) {
      imageProvider = AssetImage(imageAssertDefault);
    } else {
      imageProvider = FileImage(File(imagePath!));
    }

    final image = Image(
      image: imageProvider,
      alignment: Alignment.center,
      fit: BoxFit.contain,
      isAntiAlias: true,
    );

    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));

    final painter = DetectResultPainter();

    return FutureBuilder<ui.Image>(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          painter.setImageSize(Size(snapshot.data!.width.toDouble(),
              snapshot.data!.height.toDouble()));
          painter.setBoundingBoxes(List<Rect>.generate(
              5,
              (i) => Rect.fromLTRB(
                    100.0 * i,
                    100.0 * i,
                    100.0 * (i + 1),
                    100.0 * (i + 1),
                  )));

          return Stack(alignment: Alignment.center, children: [
            CustomPaint(
              foregroundPainter: painter,
              child: image,
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Text(
                    '${imagePath ?? "@$imageAssertDefault"}\n'
                    '${snapshot.data!.width}x${snapshot.data!.height}',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize:
                            Theme.of(context).textTheme.labelLarge?.fontSize))),
          ]);
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
