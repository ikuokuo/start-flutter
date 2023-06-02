# demo_intl

[Internationalizing Flutter apps](https://docs.flutter.dev/accessibility-and-localization/internationalization)

Create project:

```bash
flutter create demo_intl
```

Add `intl` package:

```bash
cd demo_intl
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
```

Edit `pubspec.yaml`:

```yaml
flutter:
  generate: true
```

Add `lib/l10n/app_en.arb`:

```json
{
  "helloWorld": "Hello World!",
  "@helloWorld": {
    "description": "The conventional newborn programmer greeting"
  }
}
```

Add `lib/l10n/app_zh.arb`:

```json
{
  "helloWorld": "你好，世界！"
}
```

Codegen:

```bash
flutter gen-l10n
```

Import:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

return const MaterialApp(
  title: 'Localizations Sample App',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: MyHomePage(),
);
```

Run:

```bash
flutter run
```

<!--
flutter pub add event_bus
-->
