// import 'dart:convert';
//
// import 'package:dartz/dartz.dart';
// import 'package:uae_pass/src/core/api/data_source/network_info/network_info.dart';
// import 'package:uae_pass/src/core/api/model/failure.dart';
// import 'package:uae_pass/src/core/api/model/success.dart';
// import 'package:uae_pass/src/core/const/UAEPassApiConstant.dart';
// import 'package:uae_pass/src/core/flavour/flavour_config.dart';
// import 'package:uae_pass/src/features/uae_pass/screens/uae_pass_web_view_page/data/models/UAEPassAccessToken.dart';
// import 'package:uae_pass/src/features/uae_pass/screens/uae_pass_web_view_page/domain/uae_pass_repo.dart';
//
// import '../models/SignerResModel.dart';
// import '../models/UAEDataModel.dart';
//
// class UaePassRepoImpl extends UaePassRepo {
//   final NetworkInfo? networkInfo;
//   final UaePassClient? restClient;
//
//   UaePassRepoImpl({this.networkInfo, this.restClient}) : super(networkInfo);
//
//   static String signatureAuthToken = "";
//   SignerResModel? signerResModel;
//
//   String getBearerAuthTokenHeader(String authToken) => "Bearer " + authToken;
//
//   Map<String, String> getHeader(String authorization) => {
//         KEY_AUTHORIZATION: authorization,
//         KEY_CONTENT_TYPE: "application/x-www-form-urlencoded; charset=UTF-8"
//       };
//
//   // For Access Token for UAE Pass Login
//   @override
//   Future<Either<Failure, Success>> callUAEPassAccessToken(String code) async =>
//       baseApiMethod(() => callUAEPassAccessTokenApiCall(code));
//
//   Future<Either<Failure, Success>> callUAEPassAccessTokenApiCall(
//       String code) async {
//     String basicAuthCredentials =
//         "${FlavourConfig.instance!.clientId}:${FlavourConfig.instance!.clientSecret}";
//     basicAuthCredentials =
//         KEY_BASIC_AUTH_TOKEN + base64Encode(utf8.encode(basicAuthCredentials));
//     UAEPassAccessToken model = UAEPassAccessToken(
//       code: code,
//       grant_type: KEY_AUTHORIZATION_CODE,
//       redirect_uri: FlavourConfig.instance!.redirectUrl,
//     );
//
//     try {
//       Map<String, dynamic>? data = await ((await restClient!
//               .getClientWithHeaders(getHeader(basicAuthCredentials)))
//           .getUAEAccessToken(
//         model.grant_type!,
//         model.code!,
//         model.redirect_uri!,
//       ));
//       if (data == null) {
//         return Left(ServerFailure(errorMessage: "", statusCode: PROFILE_ERROR));
//       } else {
//         return Right(Success(data: data[KEY_ACCESS_TOKEN]));
//       }
//     } catch (e) {
//       return Left(ServerFailure(errorMessage: "", statusCode: PROFILE_ERROR));
//     }
//   }
//
//   // For UAE Pass Login
//   @override
//   Future<Either<Failure, Success>> getUserData(String? accessToken) async =>
//       baseApiMethod(() => getUserDataApiCall(accessToken!));
//
//   Future<Either<Failure, Success>> getUserDataApiCall(
//       String accessToken) async {
//     dynamic response = await (await restClient!.getClientWithHeaders(
//             getHeader(getBearerAuthTokenHeader(accessToken))))
//         .getProfileData();
//     if (response == null) {
//       return Left(ServerFailure(errorMessage: "", statusCode: PROFILE_ERROR));
//     } else {
//       return Right(Success(data: UAEDataModel.fromJson(response)));
//     }
//   }
// }
