import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'evergage_flutter_method_channel.dart';

abstract class EvergageFlutterPlatform extends PlatformInterface {
  /// Constructs a EvergageFlutterPlatform.
  EvergageFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static EvergageFlutterPlatform _instance = MethodChannelEvergageFlutter();

  /// The default instance of [EvergageFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelEvergageFlutter].
  static EvergageFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EvergageFlutterPlatform] when
  /// they register themselves.
  static set instance(EvergageFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initializeEvergage({
    required String account,
    required String dataset,
    required String userId,
    required bool usePushNotification,
  }) {
    throw UnimplementedError('initializeEvergage() has not been implemented.');
  }

  Future<void> setAccountId({required String accountId}) {
    throw UnimplementedError('setAccountId() has not been implemented.');
  }

  Future<void> getAccountId() {
    throw UnimplementedError('getAccountId() has not been implemented.');
  }

  Future<void> getAnonymousId() {
    throw UnimplementedError('getAnonymousId() has not been implemented.');
  }

  Future<void> getUserId() {
    throw UnimplementedError('getUserId() has not been implemented.');
  }

  Future<void> setAccountAttribute({required String attributeName, required String attributeValue}) {
    throw UnimplementedError('setAccountAttribute() has not been implemented.');
  }

  Future<void> setUserAttribute({required String attributeName, required String attributeValue}) {
    throw UnimplementedError('setUserAttribute() has not been implemented.');
  }

  Future<void> setFirebaseToken({required String token}) {
    throw UnimplementedError('setFirebaseToken() has not been implemented.');
  }
}
