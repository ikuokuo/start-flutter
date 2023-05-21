# Start [Flutter][]

[Flutter]: https://flutter.dev/

- [Get started](https://docs.flutter.dev/get-started/)

## Practices

- [first_app/](first_app/): [Write your first app](https://docs.flutter.dev/get-started/codelab)

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

Question: https://stackoverflow.com/q/74543715
Solution: `sudo apt install libstdc++-12-dev -y`
