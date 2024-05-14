import 'package:uae_pass/src/core/api/data_source/remote_ds/remote_ds.dart';
import 'package:uae_pass/src/core/api/model/api_response.dart';
import 'package:uae_pass/src/core/const/UAEPassApiConstant.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/UAEPassAccessToken.dart';

import 'uae_pass_data_source.dart';

class AccountInfoDataSourceImpl extends UaePassDataSource {
  late final IRemoteDataSource remoteDataSource;

  AccountInfoDataSourceImpl({required this.remoteDataSource});

  @override
  Future<ApiResponse> callUAEPassAccessToken(
          UAEPassAccessToken uaePassAccessToken) =>
      remoteDataSource.executePost(
        path: UAE_PASS_TOKEN_URL,
        requestBody: uaePassAccessToken.toJson(),
      );

  @override
  Future<ApiResponse> getUserData(String? accessToken) =>
      remoteDataSource.executeGet(
        path: UAE_PASS_PROFILE_URL,
      );
}
