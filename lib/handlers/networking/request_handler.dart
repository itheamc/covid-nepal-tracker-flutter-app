import 'dart:io';

import 'package:covid_nepal_tracker/handlers/networking/urls.dart';
import 'package:dio/dio.dart';

import 'network_interceptor.dart';
import 'network_response.dart';

class RequestHandler {
  static _defaultHeaders(contentType, endpoint) => {
        HttpHeaders.contentTypeHeader: contentType,
      };

  static Future<NetworkResponse> get(
    String endpoint, {
    bool authenticate = true,
    Map<String, dynamic>? extraHeaders,
    Map<String, dynamic>? defaultHeaders,
    String contentType = "application/json",
    bool forceRefresh = false,
  }) async {
    try {
      Map<String, dynamic> headers =
          defaultHeaders ?? _defaultHeaders(contentType, endpoint);

      if (extraHeaders != null) {
        headers.addAll(extraHeaders);
      }

      var dio = Dio(
        BaseOptions(baseUrl: Urls.BASE_URL, headers: headers),
      )..interceptors.add(NetworkInterceptor());

      var res = await dio.get(endpoint);
      return res.toNetworkResponse();
    } catch (e) {
      return NetworkResponse(ErrorResponse(
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: "Something went wrong!!"));
    }
  }
}
