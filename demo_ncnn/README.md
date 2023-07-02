# demo_ncnn

## Prepare

Create project:

```bash
flutter create --project-name demo_ncnn --org dev.flutter --android-language java --ios-language objc --platforms=android,ios,linux demo_ncnn
```

Install deps:

```bash
cd demo_ncnn/

dart pub get
# dart pub add ffi path logging
# dart pub add -d ffigen

sudo apt-get install libclang-dev
```

## Linux

Download prebuild binary,

- [ncnn](https://github.com/Tencent/ncnn/releases): ncnn-YYYYMMDD-ubuntu-2204-shared.zip
- [opencv](https://github.com/nihui/opencv-mobile): opencv-mobile-4.6.0-ubuntu-2204.zip

Unzip to `demo_ncnn/linux/lib/`.

Build the `yolox` library,

```bash
cd demo_ncnn/linux/lib/
make

# cpp test
export LD_LIBRARY_PATH=dist/lib:$(echo ncnn*)/lib:$LD_LIBRARY_PATH
./dist/bin/yolox_test

# dart test
dart yolox_test.dart
```

If wanna rebuild dart bindings,

```bash
cd demo_ncnn/
dart run ffigen --config lib/yolox/config.yaml
```
