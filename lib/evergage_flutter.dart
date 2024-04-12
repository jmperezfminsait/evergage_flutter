
import 'evergage_flutter_platform_interface.dart';

class EvergageFlutter {
  Future<String?> getPlatformVersion() {
    return EvergageFlutterPlatform.instance.getPlatformVersion();
  }

  Future<void> initializeEvergage(String account, String dataset, String userId, bool usePushNotification) async {
    // Initialize Evergage
    await EvergageFlutterPlatform.instance.initializeEvergage(account: account, dataset: dataset, userId: userId, usePushNotification: usePushNotification);
  }

}
