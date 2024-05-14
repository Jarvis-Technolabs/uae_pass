import 'package:uae_pass/src/core/api/model/api_response.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/UAEPassAccessToken.dart';

abstract class UaePassDataSource {
  Future<ApiResponse> callUAEPassAccessToken(
      UAEPassAccessToken uaePassAccessToken);

  Future<ApiResponse> getUserData(String? accessToken);
}
