// ignore_for_file: avoid_print

import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' show dirname, join;

import 'package:demo_ncnn/yolox/yolox.dart';
import 'package:demo_ncnn/util/dylib_utils.dart';

void main(List<String> args) {
  final dylib = dlopenPlatformSpecific('yolox',
      path: join(dirname(Platform.script.path), 'dist/lib/'));

  final yolox = YoloX(dylib);

  var objects = yolox.objects_create();

  final imagepath = ''.toNativeUtf8();
  final err = yolox.objects_detect(imagepath.cast(), objects);
  calloc.free(imagepath);

  if (err == YO_OK) {
    print('yolox detect ok, num=${objects.ref.num}');
    for (int i = 0; i < objects.ref.num; i++) {
      var obj = objects.ref.object.elementAt(i).ref;
      print(
          '  object[$i] label=${obj.label} prob=${obj.prob} rect=${obj.rect.str()}');
    }
  } else {
    print('yolox detect fail, err=$err');
  }

  yolox.objects_destroy(objects);
}

extension RectExtension on Rect {
  String str() {
    return '{x=$x y=$y w=$w h=$h}';
  }
}
