import 'dart:io' show Platform;

import 'package:opus_flutter_android/opus_flutter_android.dart';
import 'package:opus_flutter_ios/opus_flutter_ios.dart';
import 'package:opus_flutter_mac/opus_flutter_mac.dart';
import 'package:opus_flutter_windows/opus_flutter_windows.dart';
import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

// A workaround for flutter/flutter#52267
// TODO: revise once the issue got resolved
void _flutterIssue52267Workaround() {
  if (Platform.isAndroid) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterAndroid)) {
      OpusFlutterPlatform.instance = new OpusFlutterAndroid();
    }
  } else if (Platform.isIOS) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterIOS)) {
      OpusFlutterPlatform.instance = new OpusFlutterIOS();
    }
  }
}

// A workaround for flutter/flutter#81421
// TODO: revise once the issue got resolved
void _flutterIssue81421Workaround() {
  if (Platform.isWindows) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterWindows)) {
      OpusFlutterWindows.registerWith();
    }
  } else if (Platform.isMacOS) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterMAC)) {
      OpusFlutterPlatform.instance = new OpusFlutterMAC();
    }
  }
}

/// On supported platforms a `DynamicLibrary` of the [opus audio codec](https://opus-codec.org/) is returned,
/// whereas on not supported platforms an [UnsupportedError] is thrown.
///
/// On platforms where there is [dart:ffi], the returned object is a
/// [dart:ffi DynamicLibrary](https://api.dart.dev/stable/dart-ffi/DynamicLibrary-class.html),
/// so it is safe to cast it.
///
/// On the web, where there is no [dart:ffi], the returned object is a
/// [web_ffi DynamicLibrary](https://pub.dev/documentation/web_ffi/latest/web_ffi/DynamicLibrary-class.html),
/// so it is safe to cast it.
Future<dynamic> load() {
  _flutterIssue52267Workaround();
  _flutterIssue81421Workaround();
  return OpusFlutterPlatform.instance.load();
}
