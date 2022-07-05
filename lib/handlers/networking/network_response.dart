import 'package:dio/dio.dart';

///---------------------------------@itheamc----------------------------------
/// Class For Network Response
class NetworkResponse {
  final Response _response;

  ResponseType get responseType => _response is SuccessResponse
      ? ResponseType.success
      : _response is FailureResponse
          ? ResponseType.failure
          : ResponseType.error;

  String get message => _response.statusMessage ?? "wentWrong";

  bool get isSuccess => responseType == ResponseType.success;

  dynamic get data => _response.data;

  int? get statusCode => _response.statusCode;

  bool get hasData => data != null;

  NetworkResponse(
    this._response,
  );
}

///---------------------------------@itheamc----------------------------------
/// Success Network Response
class SuccessResponse extends Response {
  SuccessResponse({
    required super.requestOptions,
    super.data,
    super.headers,
    super.isRedirect,
    super.statusCode,
    super.statusMessage,
    super.redirects,
    super.extra,
  });

  factory SuccessResponse.fromResponse(Response response) {
    return SuccessResponse(
      data: response.data,
      requestOptions: response.requestOptions,
      headers: response.headers,
      isRedirect: response.isRedirect,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      extra: response.extra,
    );
  }
}

///---------------------------------@itheamc----------------------------------
/// Failure Network Response
class FailureResponse extends Response {
  FailureResponse({
    required super.requestOptions,
    super.data,
    super.headers,
    super.isRedirect,
    super.statusCode,
    super.statusMessage,
    super.redirects,
    super.extra,
  });

  factory FailureResponse.fromResponse(Response response) {
    return FailureResponse(
      data: response.data,
      requestOptions: response.requestOptions,
      headers: response.headers,
      isRedirect: response.isRedirect,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      extra: response.extra,
    );
  }
}

///---------------------------------@itheamc----------------------------------
/// Error Network Response
class ErrorResponse extends Response {
  ErrorResponse({
    required super.requestOptions,
    super.data,
    super.headers,
    super.isRedirect,
    super.statusCode,
    super.statusMessage,
    super.redirects,
    super.extra,
  });
}

///---------------------------------@itheamc----------------------------------
/// Network Response Type
enum ResponseType { success, failure, error }

///---------------------------------@itheamc----------------------------------
/// Network Request Status
enum NetworkRequestStatus { none, requesting, completed }

///---------------------------------@itheamc----------------------------------
/// Extension Function
extension ResponseExtension on Response {
  NetworkResponse toNetworkResponse() {
    return NetworkResponse(this);
  }
}
