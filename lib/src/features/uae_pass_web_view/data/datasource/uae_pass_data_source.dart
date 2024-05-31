import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_pass_access_token.dart';

abstract class UaePassDataSource {
  Future<dynamic> callUAEPassAccessToken(UAEPassAccessToken uaePassAccessToken);

  Future<dynamic> getUserData(String accessToken);
}
