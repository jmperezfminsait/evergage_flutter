import 'evergage_flutter_platform_interface.dart';

class EvergageFlutter {
  Future<String?> getPlatformVersion() {
    return EvergageFlutterPlatform.instance.getPlatformVersion();
  }

  Future<void> initializeEvergage(String account, String dataset, String userId,
      bool usePushNotification) async {
    // Initialize Evergage
    await EvergageFlutterPlatform.instance.initializeEvergage(
        account: account,
        dataset: dataset,
        userId: userId,
        usePushNotification: usePushNotification);
  }

  Future<void> setAccountId(String accountId) async {
    await EvergageFlutterPlatform.instance.setAccountId(accountId: accountId);
  }

  Future<void> getAccountId() async {
    await EvergageFlutterPlatform.instance.getAccountId();
  }

  Future<void> getAnonymousId() async {
    await EvergageFlutterPlatform.instance.getAnonymousId();
  }

  Future<void> getUserId() async {
    await EvergageFlutterPlatform.instance.getUserId();
  }

  Future<void> setAccountAttribute(
      String attributeName, String attributeValue) async {
    await EvergageFlutterPlatform.instance.setAccountAttribute(
        attributeName: attributeName, attributeValue: attributeValue);
  }

  Future<void> setUserAttribute(
      String attributeName, String attributeValue) async {
    await EvergageFlutterPlatform.instance.setUserAttribute(
        attributeName: attributeName, attributeValue: attributeValue);
  }

  Future<void> setFirebaseToken(String token) async {
    await EvergageFlutterPlatform.instance.setFirebaseToken(token: token);
  }

  Future<void> sendEvent(
    String eventTrigger,
  ) {
    return EvergageFlutterPlatform.instance.sendEvent(eventTrigger);
  }
}
