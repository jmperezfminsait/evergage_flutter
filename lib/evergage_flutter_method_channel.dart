import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'evergage_flutter_platform_interface.dart';

/// An implementation of [EvergageFlutterPlatform] that uses method channels.
class MethodChannelEvergageFlutter extends EvergageFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('evergage_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
