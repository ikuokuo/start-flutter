import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'log.dart';

// Process And Show An Image In Flutter
//  https://medium.com/@ys.commerciale/process-and-show-an-image-in-flutter-aebb0054ce94
//  https://stackoverflow.com/a/60356791

Future<img.Image?> loadAsset(String assetName,
    {AssetBundle? bundle, String? package}) async {
  final keyName = package == null ? assetName : 'packages/$package/$assetName';
  final bytes = await (bundle ?? rootBundle).load(keyName);
  return img.decodeImage(bytes.buffer.asUint8List());
}

Future<img.Image?> loadFile(String imagePath) async {
  final file = File(imagePath);
  final bytes = await file.readAsBytes();
  return img.decodeImage(bytes.buffer.asUint8List());
}

Future<ui.Image> toUiImage(img.Image image) async {
  ui.Codec codec = await ui.instantiateImageCodec(img.encodePng(image));
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}

class ImageData {
  img.Image image;
  ui.Image imageUi;
  String imagePath;
  Duration loadTime;

  ImageData(this.image, this.imageUi, this.imagePath, this.loadTime);
}

Future<ImageData> loadImage(String? imagePath) async {
  final timebeg = DateTime.now();
  // await Future.delayed(const Duration(seconds: 5));

  img.Image? image;
  if (imagePath == null) {
    image = await loadAsset('assets/dog.jpg', package: 'ncnn_yolox');
    imagePath = '@assets/dog.jpg';
    log.info('loadAsset imagePath=$imagePath');
  } else {
    image = await loadFile(imagePath);
    log.info('loadImage imagePath=$imagePath');
  }

  ui.Image? imageUi;
  if (image != null) {
    imageUi = await toUiImage(image);
  }

  final timecost = DateTime.now().difference(timebeg);

  if (image == null || imageUi == null) {
    throw Exception('Image load failed');
  }

  return ImageData(image, imageUi, imagePath, timecost);
}
