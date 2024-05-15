import 'package:uae_pass/src/core/const/api_constants.dart';

import 'uae_data_model.dart';

class UAEPassWebViewResultModel {
  bool status;
  int errorType;
  String? message;
  UAEDataModel? uaeDataModel;
  String documentFilePath;

  UAEPassWebViewResultModel({
    required this.status,
    required this.message,
    this.uaeDataModel,
    this.documentFilePath = "",
    this.errorType = RESULT_OK,
  });

  @override
  String toString() {
    return 'UAEPassWebViewResultModel{status: $status, errorType: $errorType, message: $message, uaeDataModel: $uaeDataModel, documentFilePath: $documentFilePath}';
  }
}
