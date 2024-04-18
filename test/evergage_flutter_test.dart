import 'package:flutter_test/flutter_test.dart';
import 'package:evergage_flutter/evergage_flutter.dart';
import 'package:evergage_flutter/evergage_flutter_platform_interface.dart';
import 'package:evergage_flutter/evergage_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEvergageFlutterPlatform
    with MockPlatformInterfaceMixin
    implements EvergageFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> initializeEvergage({required String account, required String dataset, required String userId, required bool usePushNotification}) {
    // TODO: implement initializeEvergage
    throw UnimplementedError();
  }

  @override
  Future<void> getAccountId() {
    // TODO: implement getAccountId
    throw UnimplementedError();
  }

  @override
  Future<void> getAnonymousId() {
    // TODO: implement getAnonymousId
    throw UnimplementedError();
  }

  @override
  Future<void> getUserId() {
    // TODO: implement getUserId
    throw UnimplementedError();
  }

  @override
  Future<void> setAccountId({required String accountId}) {
    // TODO: implement setAccountId
    throw UnimplementedError();
  }

  @override
  Future<void> setAccountAttribute({required String attributeName, required String attributeValue}) {
    // TODO: implement setAccountAttribute
    throw UnimplementedError();
  }

  @override
  Future<void> setUserAttribute({required String attributeName, required String attributeValue}) {
    // TODO: implement setUserAttribute
    throw UnimplementedError();
  }

  @override
  Future<void> setFirebaseToken({required String token}) {
    // TODO: implement setFirebaseToken
    throw UnimplementedError();
  }

  @override
  Future<void> trackAction({required String action}) {
    // TODO: implement trackAction
    throw UnimplementedError();
  }
}

void main() {
  final EvergageFlutterPlatform initialPlatform = EvergageFlutterPlatform.instance;

  test('$MethodChannelEvergageFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEvergageFlutter>());
  });

  test('getPlatformVersion', () async {
    EvergageFlutter evergageFlutterPlugin = EvergageFlutter();
    MockEvergageFlutterPlatform fakePlatform = MockEvergageFlutterPlatform();
    EvergageFlutterPlatform.instance = fakePlatform;

    expect(await evergageFlutterPlugin.getPlatformVersion(), '42');
  });
}
