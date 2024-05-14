import 'package:uae_pass/src/core/const/UAEPassApiConstant.dart';

import 'UAEDataModel.dart';

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
