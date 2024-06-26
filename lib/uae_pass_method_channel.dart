import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ft_uaepass/src/core/const/app_constants.dart';
import 'package:ft_uaepass/uae_pass_platform_interface.dart';

/// An implementation of [UaePassPlatform] that uses method channels.
class MethodChannelUaePass extends UaePassPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(kMethodChannelName);

  @override
  Future<dynamic> openUaePassApp({
    required String url,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent(kUrl, () => url);
    return await methodChannel.invokeMethod<String>(kOpenUaePassApp, args);
  }
}
