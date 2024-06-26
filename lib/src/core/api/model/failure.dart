import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  final int statusCode;

  const Failure({
    required this.errorMessage,
    required this.statusCode,
  });
}

class ServerFailure extends Failure {
  final String errorMessage;
  final int statusCode;
  final String? apiStatusCode;

  const ServerFailure({
    required this.errorMessage,
    required this.statusCode,
    this.apiStatusCode,
  }) : super(
          errorMessage: errorMessage,
          statusCode: statusCode,
        );

  @override
  List<Object?> get props => [
        errorMessage,
        statusCode,
        apiStatusCode,
      ];
}
