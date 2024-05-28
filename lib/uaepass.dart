import 'uae_pass_platform_interface.dart';

class Uaepass {
  Future<String?> getPlatformVersion() {
    return UaePassPlatform.instance.getPlatformVersion();
  }
}
