// Event Bus
//  https://pub.dev/packages/event_bus
// BLoC
//  https://pub.dev/packages/flutter_bloc
import 'dart:ui';

import 'package:event_bus/event_bus.dart';

var eventBus = EventBus();

class LocaleChangeEvent {
  Locale locale;

  LocaleChangeEvent(this.locale);
}
