# ncnn_yolox

## Prepare

Create ffi plugin:

```bash
mkdir -p plugins; cd plugins
flutter create --org dev.flutter -t plugin_ffi --platforms=android,ios,linux ncnn_yolox
```

## References

- [Developing FFI plugin packages](https://docs.flutter.dev/packages-and-plugins/developing-packages#plugin-ffi)
- [Integrating C library in a desktop Flutter app using Dart FFI](https://medium.com/flutter-community/integrating-c-library-in-a-desktop-flutter-app-using-dart-ffi-32560cb1169b)
  - [使用Dart FFI在Flutter桌面应用中集成C库](https://zhuanlan.zhihu.com/p/458488070)
