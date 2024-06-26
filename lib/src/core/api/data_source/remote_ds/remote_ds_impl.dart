import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:ft_uaepass/src/core/const/api_constants.dart';
import 'package:ft_uaepass/src/core/di/injection_container.dart';
import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';
import 'package:ft_uaepass/src/core/util/common_utilities.dart';

import '../../model/api_response.dart';
import 'remote_ds.dart';

const String kGetMethod = 'GET';
const String kPostMethod = 'POST';

CommonUtilities commonUtilities = sl();

class RemoteDataSourceImpl extends IRemoteDataSource {
  late final Dio client;

  RemoteDataSourceImpl({required this.client}) {
    setClient();
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  Future<void> setClient() async {
    // var certificate =
    //     (await rootBundle.load(FlavourConfig.instance.certificatePath))
    //         .buffer
    //         .asInt8List();
    // client.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     SecurityContext clientContext =
    //         SecurityContext(withTrustedRoots: false);
    //     clientContext.setTrustedCertificatesBytes(certificate);
    //     final HttpClient httpClient = HttpClient(context: clientContext);
    //     return httpClient;
    //   },
    // );

    client.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        HttpClient httpClient = HttpClient();
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return httpClient;
      },
    );
  }

  Future<Map<String, dynamic>> getHeader({String? token}) async {
    Map<String, dynamic> header = <String, dynamic>{};
    if (token != null) {
      header.putIfAbsent(
        kKeyAuthorization,
        () => token,
      );
    }
    header.putIfAbsent(
      kContentType,
      () => kApplicationXWwwFromUrlEncodedContentType,
    );
    return header;
  }

  String getBaseUrl() => FlavourConfig.instance.apiBaseUrl;

  Future<dynamic> callAPI({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? requestBody,
    String? token,
    String? baseURL,
  }) async {
    ///Header
    final Map<String, dynamic> header = await getHeader(token: token);

    /// Query parameters
    final Map<String, dynamic> queryParameters0 = <String, dynamic>{};
    if (queryParameters != null) {
      queryParameters0.addAll(queryParameters);
    }

    ///Request body
    final Map<String, dynamic> requestBody0 = <String, dynamic>{};
    if (requestBody != null) {
      requestBody0.addAll(requestBody);
    }

    final response = await client.fetch(
      _setStreamType<ApiResponse>(
        Options(
          method: method,
          headers: header,
          extra: <String, dynamic>{},
        )
            .compose(
              client.options,
              path,
              queryParameters: queryParameters,
              data: requestBody,
            )
            .copyWith(
              baseUrl: baseURL ?? getBaseUrl(),
            ),
      ),
    );
    return response;
  }

  @override
  Future<dynamic> executeGet({
    required String path,
    String? token,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    ///Get Request
    return await callAPI(
      path: path,
      method: kGetMethod,
      queryParameters: queryParameters,
      requestBody: requestBody,
      token: token,
    );
  }

  @override
  Future<dynamic> executePost({
    required String path,
    String? token,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    ///Post Request
    return await callAPI(
      path: path,
      method: kPostMethod,
      queryParameters: queryParameters,
      requestBody: requestBody,
      token: token,
    );
  }
}
