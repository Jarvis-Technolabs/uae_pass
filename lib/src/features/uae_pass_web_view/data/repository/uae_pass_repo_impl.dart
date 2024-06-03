import 'package:dartz/dartz.dart';
import 'package:ft_uaepass/src/core/api/data_source/network_info/network_info.dart';
import 'package:ft_uaepass/src/core/api/model/failure.dart';
import 'package:ft_uaepass/src/core/api/model/success.dart';
import 'package:ft_uaepass/src/core/const/api_constants.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/datasource/uae_pass_data_source.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_data_model.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_pass_access_token.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

class UaePassRepoImpl extends UaePassRepo {
  late final UaePassDataSource uaePassDataSource;
  @override
  late final NetworkInfo networkInfo;

  UaePassRepoImpl({
    required this.uaePassDataSource,
    required this.networkInfo,
  }) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> callUAEPassAccessToken(
          UAEPassAccessToken uaePassAccessToken) =>
      baseApiMethod(() => callUAEPassAccessTokenAPI(uaePassAccessToken));

  Future<Either<Failure, Success>> callUAEPassAccessTokenAPI(
      UAEPassAccessToken uaePassAccessToken) async {
    dynamic response =
        await uaePassDataSource.callUAEPassAccessToken(uaePassAccessToken);
    if (response.statusCode != 200) {
      return Left(
        ServerFailure(
          errorMessage: response.message!,
          statusCode: response.statusCode ?? 0,
        ),
      );
    } else {
      return Right(
        Success(
          data: response.data[kKeyAccessToken],
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> getUserData(String accessToken) =>
      baseApiMethod(() => getUserDataAPI(accessToken));

  Future<Either<Failure, Success>> getUserDataAPI(String accessToken) async {
    dynamic response = await uaePassDataSource.getUserData(accessToken);
    if (response.statusCode != 200) {
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
