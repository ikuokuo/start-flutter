// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: curly_braces_in_flow_control_structures

// https://github.com/dart-lang/sdk/blob/main/samples/ffi/dylib_utils.dart

import 'dart:ffi';
import 'dart:io' show Platform;

String _platformPath(String name, String path) {
  if (Platform.isLinux || Platform.isAndroid || Platform.isFuchsia)
    return '${path}lib$name.so';
  if (Platform.isMacOS) return '${path}lib$name.dylib';
  if (Platform.isWindows) return '$path$name.dll';
  throw Exception('Platform not implemented');
}

DynamicLibrary dlopenPlatformSpecific(String name, {String path = ""}) {
  String fullPath = _platformPath(name, path);
  return DynamicLibrary.open(fullPath);
}
