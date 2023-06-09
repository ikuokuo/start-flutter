# Start [Flutter][]

[Flutter]: https://flutter.dev/

[![Status](https://img.shields.io/badge/Flutter-3.10.0-brightgreen)](https://github.com/flutter/flutter)

- [Get started](https://docs.flutter.dev/get-started/)

## Practices

- [first_app/](first_app/): [Write your first app](https://docs.flutter.dev/get-started/codelab)
- [demo_intl/](demo_intl/): [Internationalizing Flutter apps](https://docs.flutter.dev/accessibility-and-localization/internationalization)
- [demo_mobx/](demo_mobx/): [MobX Counter Example](https://mobx.netlify.app/getting-started/)
- [demo_ncnn/](demo_ncnn/): ncnn yolox object detection example
- plugins
  - [ncnn_yolox/](plugins/ncnn_yolox/): ncnn yolox FFI plugin

## Issues

### `flutter doctor` `HTTP host is not reachable`

- Open `${FLUTTER_HOME}\packages\flutter_tools\lib\src\http_host_validator.dart`
  - Fix `HTTP host "https://maven.google.com/" is not reachable`
    - Change `https://maven.google.com/` to `https://dl.google.com/dl/android/maven2/`
  - Fix `HTTP host "https://cloud.google.com/" is not reachable`
    - Set `kPubDevHttpHost` value to `https://pub.flutter-io.cn/`
    - Set `kgCloudHttpHost` value to `https://storage.flutter-io.cn/`
  - Remove `${FLUTTER_HOME}\bin\cache`

### `/usr/bin/ld: cannot find -lstdc++`

- Question: https://stackoverflow.com/q/74543715
- Solution: `sudo apt install libstdc++-12-dev -y`

## References

- [Flutter Awesome Site](https://flutterawesome.com/)
- [Flutter Awesome List](https://github.com/Solido/awesome-flutter)
