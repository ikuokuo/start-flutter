// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

/// Bindings to `yolox.h`.
class YoloX {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  YoloX(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  YoloX.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  ffi.Pointer<Objects> objects_create() {
    return _objects_create();
  }

  late final _objects_createPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<Objects> Function()>>(
          'objects_create');
  late final _objects_create =
      _objects_createPtr.asFunction<ffi.Pointer<Objects> Function()>();

  void objects_destroy(
    ffi.Pointer<Objects> objects,
  ) {
    return _objects_destroy(
      objects,
    );
  }

  late final _objects_destroyPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<Objects>)>>(
          'objects_destroy');
  late final _objects_destroy =
      _objects_destroyPtr.asFunction<void Function(ffi.Pointer<Objects>)>();

  int objects_detect(
    ffi.Pointer<ffi.Char> imagepath,
    ffi.Pointer<Objects> objects,
  ) {
    return _objects_detect(
      imagepath,
      objects,
    );
  }

  late final _objects_detectPtr = _lookup<
      ffi.NativeFunction<
          yo_err_t Function(
              ffi.Pointer<ffi.Char>, ffi.Pointer<Objects>)>>('objects_detect');
  late final _objects_detect = _objects_detectPtr
      .asFunction<int Function(ffi.Pointer<ffi.Char>, ffi.Pointer<Objects>)>();
}

final class Rect extends ffi.Struct {
  @ffi.Float()
  external double x;

  @ffi.Float()
  external double y;

  @ffi.Float()
  external double w;

  @ffi.Float()
  external double h;
}

final class Object extends ffi.Struct {
  @ffi.Int()
  external int label;

  @ffi.Float()
  external double prob;

  external Rect rect;
}

final class Objects extends ffi.Struct {
  @ffi.Int()
  external int num;

  external ffi.Pointer<Object> object;
}

typedef yo_err_t = ffi.Int;

const int YO_OK = 0;

const int YO_ERROR = -1;
