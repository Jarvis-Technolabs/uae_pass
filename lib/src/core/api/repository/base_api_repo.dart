import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../const/api_constants.dart';
import '../../const/string_constants.dart';
import '../data_source/network_info/network_info.dart';
import '../model/failure.dart';
import '../model/success.dart';

abstract class BaseApiRepo {
  final NetworkInfo networkInfo;

  BaseApiRepo({
    required this.networkInfo,
  });

  Future<Either<Failure, Success>> baseApiMethod(
    Future<Either<Failure, Success>> Function() apiCall,
  ) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return InternetConnectionException();
    }
    try {
      return await apiCall();
    } on DioException catch (e) {
      String statusMessage = "";
      int statusCode = LOCAL_ERROR_CODE;
      if (e.response != null) {
        statusCode = e.response!.statusCode!;
        statusMessage = LABEL_INTERNAL_SERVER_ERROR;
        if (statusCode == UN_AUTHORISED_ERROR_CODE) {
          statusMessage = LABEL_UNAUTHORIZED_USER;
        }
      } else {
        if (e.error is SocketException) {
          return timeOutException();
        }
      }
      return Left(
        ServerFailure(
          errorMessage: statusMessage,
          statusCode: statusCode,
        ),
      );
    } on TimeoutException {
      return Left(defaultFailure());
    } catch (e) {
      if (e.toString().contains('AuthorizationErrorCode.canceled')) {
        return Left(
          ServerFailure(
            errorMessage: LABEL_SOMETHING_WENT_WRONG,
            statusCode: LOCAL_ERROR_CODE,
          ),
        );
      }

      if (e.toString().contains(SOCKET_EXCEPTION)) {
        return timeOutException();
      }
      return Left(
        defaultFailure(),
      );
    } finally {}
  }

  ServerFailure defaultFailure() => ServerFailure(
        errorMessage: LABEL_SOMETHING_WENT_WRONG,
        statusCode: LOCAL_ERROR_CODE,
      );

  Left<Failure, Success> InternetConnectionException() => Left(
        ServerFailure(
          errorMessage: LABEL_INTERNET_CONNECTION,
          statusCode: LOCAL_ERROR_CODE,
        ),
      );

  Left<Failure, Success> timeOutException() => Left(
        ServerFailure(
          errorMessage: LABEL_TIMEOUT_ERROR_MESSAGE,
          statusCode: LOCAL_ERROR_CODE,
        ),
      );
}
