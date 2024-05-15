import 'package:dartz/dartz.dart';
import 'package:uae_pass/src/core/api/data_source/network_info/network_info.dart';
import 'package:uae_pass/src/core/api/model/api_response.dart';
import 'package:uae_pass/src/core/api/model/failure.dart';
import 'package:uae_pass/src/core/api/model/success.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/datasource/uae_pass_data_source.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/uae_data_model.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/uae_pass_access_token.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

import '../../../../core/const/UAEPassApiConstant.dart';

class UaePassRepoImpl extends UaePassRepo {
  late final UaePassDataSource uaePassDataSource;
  late final NetworkInfo networkInfo;

  UaePassRepoImpl(this.uaePassDataSource, this.networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, Success>> callUAEPassAccessToken(
          UAEPassAccessToken uaePassAccessToken) =>
      baseApiMethod(() => callUAEPassAccessTokenAPI(uaePassAccessToken));

  Future<Either<Failure, Success>> callUAEPassAccessTokenAPI(
      UAEPassAccessToken uaePassAccessToken) async {
    ApiResponse response =
        await uaePassDataSource.callUAEPassAccessToken(uaePassAccessToken);
    if (!response.status!) {
      return Left(ServerFailure(
          errorMessage: response.message!,
          statusCode: response.statusCode ?? 0));
    } else {
      return Right(
        Success(
          data: response.data[KEY_ACCESS_TOKEN],
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> getUserData(String accessToken) =>
      baseApiMethod(() => getUserDataAPI(accessToken));

  Future<Either<Failure, Success>> getUserDataAPI(String accessToken) async {
    ApiResponse response = await uaePassDataSource.getUserData(accessToken);
    if (!response.status!) {
      return Left(
        ServerFailure(
          errorMessage: response.message!,
          statusCode: response.statusCode ?? 0,
        ),
      );
    } else {
      UAEDataModel uaeDataModel = UAEDataModel.fromJson(response.data);
      return Right(
        Success(data: uaeDataModel),
      );
    }
  }
}
