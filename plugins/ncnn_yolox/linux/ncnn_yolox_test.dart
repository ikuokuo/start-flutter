// ignore_for_file: avoid_print

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'package:ncnn_yolox/ncnn_yolox_bindings_generated.dart';

void main(List<String> args) {
  final yoloxLib = NcnnYoloxBindings(dlopen('ncnn_yolox', 'build/shared'));

  const assetsDir = '../assets';
  final imagePath = '$assetsDir/dog.jpg'.toNativeUtf8();
  final modelPath = '$assetsDir/yolox_nano_fp16.bin'.toNativeUtf8();
  final paramPath = '$assetsDir/yolox_nano_fp16.param'.toNativeUtf8();

  final yolox = yoloxLib.yoloxCreate();
  yolox.ref.model_path = modelPath.cast();
  yolox.ref.param_path = paramPath.cast();
  yolox.ref.nms_thresh = 0.45;
  yolox.ref.conf_thresh = 0.25;
  yolox.ref.target_size = 416;
  // yolox.ref.target_size = 640;

  final detectResult = yoloxLib.detectResultCreate();

  final err =
      yoloxLib.detectWithImagePath(yolox, imagePath.cast(), detectResult);

  if (err == YOLOX_OK) {
    final num = detectResult.ref.object_num;
    print('yolox detect ok, num=$num');
    for (int i = 0; i < num; i++) {
      var obj = detectResult.ref.object.elementAt(i).ref;
      print('  object[$i] label=${obj.label}'
          ' prob=${obj.prob.toStringAsFixed(2)} rect=${obj.rect.str()}');
    }
  } else {
    print('yolox detect fail, err=$err');
  }

  calloc.free(imagePath);
  calloc.free(modelPath);
  calloc.free(paramPath);

  yoloxLib.detectResultDestroy(detectResult);
  yoloxLib.yoloxDestroy(yolox);
}

/// The dynamic library in which the symbols for [NcnnYoloxBindings] can be found.
DynamicLibrary dlopen(String name, String path) {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$path/$name.framework/$name');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('$path/lib$name.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$path/$name.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}

extension RectExtension on Rect {
  String str() {
    return '{x=${x.toStringAsFixed(2)} y=${y.toStringAsFixed(2)}'
        ' w=${w.toStringAsFixed(2)} h=${h.toStringAsFixed(2)}}';
  }
}
