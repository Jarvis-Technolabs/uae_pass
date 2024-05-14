import 'package:uae_pass/src/core/flavour/flavour_config.dart';
import 'package:uae_pass/src/core/flavour/flavour_enum.dart';

class Flavour {
  static void setStagingFlavor() {
    FlavourConfig(
      flavorEnum: FlavourEnum.staging,
      apiBaseUrl: "https://stg-id.uaepass.ae/",
      clientId: "sandbox_stage",
      clientSecret: "sandbox_stage",
      redirectUrl: "https://pftmapp.pension.gov.ae/uaepass.aspx",
      androidPackageId: "ae.uaepass.mainapp.stg",
      iosBundleSchema: "uaepassstg://",
      cancelledUrl: "com.mims.test://uaepass",
      certificatePath: "assets/cert/qa_uaepass.pem",
    );
  }

  static void setProdFlavor() {
    FlavourConfig(
      flavorEnum: FlavourEnum.prod,
      apiBaseUrl: "https://id.uaepass.ae/",
      clientId: "adrpbfm_mob_prod",
      clientSecret: "P0m2frrrawxtbh5out2",
      redirectUrl: "https://mservicepre.pension.gov.ae/uaepass.aspx",
      androidPackageId: "ae.uaepass.mainapp",
      iosBundleSchema: "uaepass://",
      cancelledUrl: "https://ids.uaepass.ae/authenticationendpoint/retry.do",
      certificatePath: "assets/cert/prod_uaepass.pem",
    );
  }
}
