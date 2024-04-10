
import 'evergage_flutter_platform_interface.dart';

class EvergageFlutter {
  Future<String?> getPlatformVersion() {
    return EvergageFlutterPlatform.instance.getPlatformVersion();
  }
}
