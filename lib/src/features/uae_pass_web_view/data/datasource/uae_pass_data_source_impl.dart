import 'dart:convert';

import 'package:ft_uaepass/src/core/api/data_source/remote_ds/remote_ds.dart';
import 'package:ft_uaepass/src/core/const/api_constants.dart';
import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_pass_access_token.dart';

import 'uae_pass_data_source.dart';

class UaePassDataSourceImpl extends UaePassDataSource {
  late final IRemoteDataSource remoteDataSource;

  UaePassDataSourceImpl({required this.remoteDataSource});

  @override
  Future<dynamic> callUAEPassAccessToken(
          UAEPassAccessToken uaePassAccessToken) =>
      remoteDataSource.executePost(
        path: kUaePassTokenUrl,
        requestBody: uaePassAccessToken.toJson(),
        token: kKeyBasicAuthToken +
            base64Encode(utf8.encode(
                "${FlavourConfig.instance.clientId}:${FlavourConfig.instance.clientSecret}")),
      );

  @override
  Future<dynamic> getUserData(String accessToken) =>
      remoteDataSource.executeGet(
        path: kUaePassProfileUrl,
        token: "Bearer $accessToken",
      );
}
