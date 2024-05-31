import 'package:dartz/dartz.dart';
import 'package:ft_uaepass/src/core/api/data_source/network_info/network_info.dart';
import 'package:ft_uaepass/src/core/api/model/failure.dart';
import 'package:ft_uaepass/src/core/api/model/success.dart';
import 'package:ft_uaepass/src/core/api/repository/base_api_repo.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_pass_access_token.dart';

abstract class UaePassRepo extends BaseApiRepo {
  UaePassRepo(NetworkInfo networkInfo) : super(networkInfo: networkInfo);

  // For Access Token for UAE Pass Login
  Future<Either<Failure, Success>> callUAEPassAccessToken(
      UAEPassAccessToken uaePassAccessToken);

  // For UAE Pass Login
  Future<Either<Failure, Success>> getUserData(String accessToken);
}
