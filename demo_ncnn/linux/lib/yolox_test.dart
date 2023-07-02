// ignore_for_file: avoid_print

import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' show dirname, join;
import 'package:logging/logging.dart';

import 'package:demo_ncnn/yolox/yolox.dart';
import 'package:demo_ncnn/util/dylib_utils.dart';

final log = Logger('YoloXTestLogger');

void main(List<String> args) {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final dylib = dlopenPlatformSpecific('yolox',
      path: join(dirname(Platform.script.path), 'dist/lib/'));

  final yoloxLib = YOLOX(dylib);

  const assetsDir = "../../assets/";
  final imagePath = join(assetsDir, "dog.jpg").toNativeUtf8();
  final modelPath = join(assetsDir, "yolox_nano_fp16.bin").toNativeUtf8();
  final paramPath = join(assetsDir, "yolox_nano_fp16.param").toNativeUtf8();

  final yolox = yoloxLib.yolox_create();
  yolox.ref.model_path = modelPath.cast();
  yolox.ref.param_path = paramPath.cast();
  yolox.ref.nms_thresh = 0.45;
  yolox.ref.conf_thresh = 0.25;
  yolox.ref.target_size = 416;
  // yolox.ref.target_size = 640;

  final detectResult = yoloxLib.detect_result_create();
  final err = yoloxLib.detect(yolox, imagePath.cast(), detectResult);
  if (err == YOLOX_OK) {
    final num = detectResult.ref.object_num;
    log.info('yolox detect ok, num=$num');
    for (int i = 0; i < num; i++) {
      var obj = detectResult.ref.object.elementAt(i).ref;
      log.info('  object[$i] label=${obj.label}'
          ' prob=${obj.prob.toStringAsFixed(2)} rect=${obj.rect.str()}');
    }
  } else {
    log.info('yolox detect fail, err=$err');
  }

  calloc.free(imagePath);
  calloc.free(modelPath);
  calloc.free(paramPath);

  yoloxLib.detect_result_destroy(detectResult);
  yoloxLib.yolox_destroy(yolox);
}

extension RectExtension on Rect {
  String str() {
    return '{x=${x.toStringAsFixed(2)} y=${y.toStringAsFixed(2)}'
        ' w=${w.toStringAsFixed(2)} h=${h.toStringAsFixed(2)}}';
  }
}
