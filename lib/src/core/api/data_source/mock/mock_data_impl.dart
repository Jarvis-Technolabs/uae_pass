import 'dart:convert';

import 'package:flutter/services.dart';

import '../../model/api_response.dart';

mixin MockDataImpl {
  Future<ApiResponse> loadFromAssetData(String path) async =>
      ApiResponse.fromJson(jsonDecode(await rootBundle.loadString(path)));
}
