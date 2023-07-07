# ncnn_yolox

## Prepare

Create ffi plugin:

```bash
mkdir -p plugins; cd plugins
flutter create --org dev.flutter -t plugin_ffi --platforms=android,ios,linux ncnn_yolox
```

```bash
cd ncnn_yolox

flutter pub outdated
flutter pub upgrade --major-versions

flutter pub run ffigen --config ffigen.yaml
```

## Linux

Download prebuild binary,

- [ncnn](https://github.com/Tencent/ncnn/releases): ncnn-YYYYMMDD-ubuntu-2204-shared.zip
- [opencv](https://github.com/nihui/opencv-mobile): opencv-mobile-4.6.0-ubuntu-2204.zip

Unzip to `ncnn_yolox/linux/lib/`.

Run app:

```bash
cd ncnn_yolox/example
flutter run -d linux -v
```

- If `OpenMP::OpenMP_CXX;` not found with `clang`, run `sudo apt-get install libclang-dev libomp-dev`.
- If `Error: The type 'YoloX' must be 'base', 'final' or 'sealed'`, add `final` to struct classes in `ncnn_yolox_bindings_generated.dart`.
- If `file INSTALL cannot copy file ... to "/usr/local/ncnn_yolox_example": Success.`, fix by `flutter clean`.

Run test:

```bash
cd ncnn_yolox/linux
make

# cpp test
./build/ncnn_yolox_test

# dart test
dart ncnn_yolox_test.dart
```

## References

- [Developing FFI plugin packages](https://docs.flutter.dev/packages-and-plugins/developing-packages#plugin-ffi)
- [Integrating C library in a desktop Flutter app using Dart FFI](https://medium.com/flutter-community/integrating-c-library-in-a-desktop-flutter-app-using-dart-ffi-32560cb1169b)
  - [使用Dart FFI在Flutter桌面应用中集成C库](https://zhuanlan.zhihu.com/p/458488070)
