import 'package:uae_pass/src/core/flavour/flavour_config.dart';
import 'package:uae_pass/src/core/flavour/flavour_enum.dart';

class Flavour {
  static void setStagingFlavor({
    required String redirectUrl,
    required String state,
  }) {
    FlavourConfig(
      flavorEnum: FlavourEnum.staging,
      apiBaseUrl: "https://stg-id.uaepass.ae/",
      clientId: "sandbox_stage",
      clientSecret: "sandbox_stage",
      redirectUrl: redirectUrl,
      state: state,
      androidPackageId: "ae.uaepass.mainapp.stg",
      iosBundleSchema: "uaepassstg://",
      cancelledUrl: "com.mims.test://uaepass",
      certificatePath: "assets/cert/qa_uaepass.pem",
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
      certificatePath: "assets/cert/prod_uaepass.pem",
    );
  }
}
