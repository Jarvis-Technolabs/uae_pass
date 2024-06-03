import 'package:ft_uaepass/src/core/const/api_constants.dart';

import 'uae_data_model.dart';

class UAEPassWebViewResultModel {
  bool status;
  int? statusCode;
  String? message;
  UAEDataModel? uaeDataModel;

  UAEPassWebViewResultModel({
    required this.status,
    required this.message,
    this.uaeDataModel,
    this.statusCode = kOkResultCode,
  });

  @override
  String toString() {
    return 'UAEPassWebViewResultModel{status: $status, statusCode: $statusCode, message: $message, uaeDataModel: $uaeDataModel}';
  }
}
