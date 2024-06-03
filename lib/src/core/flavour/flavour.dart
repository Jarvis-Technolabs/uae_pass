import 'package:ft_uaepass/src/core/const/asset_constants.dart';
import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';
import 'package:ft_uaepass/src/core/flavour/flavour_enum.dart';

class Flavour {
  static void setStagingFlavor({
    String? clientId,
    String? clientSecret,
    required String redirectUrl,
    required String state,
  }) {
    FlavourConfig(
      flavorEnum: FlavourEnum.staging,
      apiBaseUrl: "https://stg-id.uaepass.ae/",
      clientId: clientId ?? "sandbox_stage",
      clientSecret: clientSecret ?? "sandbox_stage",
      redirectUrl: redirectUrl,
      state: state,
      androidPackageId: "ae.uaepass.mainapp.stg",
      iosBundleSchema: "uaepassstg://",
      cancelledUrl: "com.mims.test://uaepass",
      certificatePath: "${kCertificatePath}qa_uaepass.pem",
    );
  }

  static void setProdFlavor({
    required String clientId,
    required String clientSecret,
    required String redirectUrl,
    required String state,
  }) {
    FlavourConfig(
      flavorEnum: FlavourEnum.prod,
      apiBaseUrl: "https://id.uaepass.ae/",
      clientId: clientId,
      clientSecret: clientSecret,
      redirectUrl: redirectUrl,
      state: state,
      androidPackageId: "ae.uaepass.mainapp",
      iosBundleSchema: "uaepass://",
      cancelledUrl: "https://ids.uaepass.ae/authenticationendpoint/retry.do",
      certificatePath: "${kCertificatePath}prod_uaepass.pem",
    );
  }
}
