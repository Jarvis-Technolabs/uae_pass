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
      return internetConnectionException();
    }
    try {
      return await apiCall();
    } on DioException catch (e) {
      String statusMessage = "";
      int statusCode = kLocalErrorCode;
      if (e.response != null) {
        statusCode = e.response!.statusCode!;
        statusMessage = kLabelInternalServerError;
        if (statusCode == kUnAuthorisedErrorCode) {
          statusMessage = kUnAuthorisedError;
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
        return const Left(
          ServerFailure(
            errorMessage: kLabelSomethingWentWrong,
            statusCode: kLocalErrorCode,
          ),
        );
      }

      if (e.toString().contains(kSocketException)) {
        return timeOutException();
      }
      return Left(
        defaultFailure(),
      );
    } finally {}
  }

  ServerFailure defaultFailure() => const ServerFailure(
        errorMessage: kLabelSomethingWentWrong,
        statusCode: kLocalErrorCode,
      );

  Left<Failure, Success> internetConnectionException() => const Left(
        ServerFailure(
          errorMessage: kLabelInternetConnection,
          statusCode: kLocalErrorCode,
        ),
      );

  Left<Failure, Success> timeOutException() => const Left(
        ServerFailure(
          errorMessage: kLabelTimeoutErrorMessage,
          statusCode: kLocalErrorCode,
        ),
      );
}
