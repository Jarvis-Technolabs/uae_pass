import 'package:ft_uaepass/src/core/flavour/flavour_enum.dart';

class FlavourConfig {
  final FlavourEnum flavorEnum;
  static FlavourConfig? _instance;
  final String apiBaseUrl,
      clientId,
      clientSecret,
      redirectUrl,
      state,
      androidPackageId,
      iosBundleSchema,
      cancelledUrl,
      certificatePath;

  factory FlavourConfig({
    required FlavourEnum flavorEnum,
    required String apiBaseUrl,
    required String clientId,
    required String clientSecret,
    required String redirectUrl,
    required String state,
    required String androidPackageId,
    required String iosBundleSchema,
    required String cancelledUrl,
    required String certificatePath,
  }) {
    _instance ??= FlavourConfig._internal(
      flavorEnum,
      apiBaseUrl,
      clientId,
      clientSecret,
      redirectUrl,
      state,
      androidPackageId,
      iosBundleSchema,
      cancelledUrl,
      certificatePath,
    );
    return _instance!;
  }

  FlavourConfig._internal(
    this.flavorEnum,
    this.apiBaseUrl,
    this.clientId,
    this.clientSecret,
    this.redirectUrl,
    this.state,
    this.androidPackageId,
    this.iosBundleSchema,
    this.cancelledUrl,
    this.certificatePath,
  );

  static FlavourConfig get instance => _instance!;

  static bool isProd() => _instance!.flavorEnum == FlavourEnum.prod;

  static bool isStaging() => _instance!.flavorEnum == FlavourEnum.staging;
}
