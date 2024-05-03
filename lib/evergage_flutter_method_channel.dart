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
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> initializeEvergage({
    required String account,
    required String dataset,
    required String userId,
    required bool usePushNotification,
  }) async {
    try {
      await methodChannel.invokeMethod('initializeEvergage', {
        'account': account,
        'dataset': dataset,
        'userId': userId,
        'usePushNotification': usePushNotification,
      });
    } on PlatformException catch (e) {
      print("Failed to initialize Evergage: '${e.message}'.");
    }
  }

  @override
  Future<void> setAccountId({required String accountId}) async {
    try {
      await methodChannel
          .invokeMethod('setAccountId', {'accountId': accountId});
    } on PlatformException catch (e) {
      print("Failed to set Evergage accountId: '${e.message}'.");
    }
  }

  @override
  Future<void> getAccountId() async {
    try {
      await methodChannel.invokeMethod('getAccountId');
    } on PlatformException catch (e) {
      print("Failed to gain Evergage accountId: '${e.message}'.");
    }
  }

  @override
  Future<void> getAnonymousId() async {
    try {
      await methodChannel.invokeMethod('getAnonymousId');
    } on PlatformException catch (e) {
      print("Failed to gain Evergage anonymousId: '${e.message}'.");
    }
  }

  @override
  Future<void> getUserId() async {
    try {
      await methodChannel.invokeMethod('getUserId');
    } on PlatformException catch (e) {
      print("Failed to gain Evergage userId: '${e.message}'.");
    }
  }

  @override
  Future<void> setAccountAttribute(
      {required String attributeName, required String attributeValue}) async {
    try {
      await methodChannel.invokeMethod('setAccountAttribute');
    } on PlatformException catch (e) {
      print("Failed to set account attribute: '${e.message}'.");
    }
  }

  @override
  Future<void> setUserAttribute(
      {required String attributeName, required String attributeValue}) async {
    try {
      await methodChannel.invokeMethod('setUserAttribute',
          {'attributeName': attributeName, 'attributeValue': attributeValue});
    } on PlatformException catch (e) {
      print("Failed to set user attribute: '${e.message}'.");
    }
  }

  @override
  Future<void> setFirebaseToken({required String token}) async {
    try {
      await methodChannel.invokeMethod('setFirebaseToken');
    } on PlatformException catch (e) {
      print("Failed to set firebase token: '${e.message}'.");
    }
  }

  @override
  Future<void> sendEvent(
    String eventTrigger,
  ) async {
    await methodChannel.invokeMethod('sendEvent', {
      'eventTrigger': eventTrigger,
    });
  }
}
