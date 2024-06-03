import 'dart:convert';

class ApiResponse {
  bool? status;
  String? message;
  dynamic data;
  int? statusCode;

  ApiResponse({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = json.encode(this.data as Map);
    }
    data['statusCode'] = statusCode;
    return data;
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
