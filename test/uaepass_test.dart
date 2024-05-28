import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:uae_pass/uae_pass_method_channel.dart';
import 'package:uae_pass/uae_pass_platform_interface.dart';
import 'package:uae_pass/uaepass.dart';

class MockUaePassPlatform
    with MockPlatformInterfaceMixin
    implements UaePassPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future openUaePassApp({required String url}) => Future.value('42');
}

void main() {
  final UaePassPlatform initialPlatform = UaePassPlatform.instance;

  test('$MethodChannelUaePass is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUaePass>());
  });

  test('getPlatformVersion', () async {
    Uaepass uaePassPlugin = Uaepass();
    MockUaePassPlatform fakePlatform = MockUaePassPlatform();
    UaePassPlatform.instance = fakePlatform;

    expect(await uaePassPlugin.getPlatformVersion(), '42');
  });

  test('getPlatformVersion', () async {
    Uaepass uaePassPlugin = Uaepass();
    MockUaePassPlatform fakePlatform = MockUaePassPlatform();
    UaePassPlatform.instance = fakePlatform;

    expect(await uaePassPlugin.getPlatformVersion(), '42');
  });
}
