import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uae_pass_method_channel.dart';

abstract class UaePassPlatform extends PlatformInterface {
  /// Constructs a UaePassPlatform.
  UaePassPlatform() : super(token: _token);

  static final Object _token = Object();

  static UaePassPlatform _instance = MethodChannelUaePass();

  /// The default instance of [UaePassPlatform] to use.
  ///
  /// Defaults to [MethodChannelUaePass].
  static UaePassPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UaePassPlatform] when
  /// they register themselves.
  static set instance(UaePassPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<dynamic> openUaePassApp({
    required String url,
  }) =>
      throw UnimplementedError('openUaePassApp() has not been implemented.');
}
