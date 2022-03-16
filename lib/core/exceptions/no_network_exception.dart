import 'base_exception.dart';

///
class NetworkIssueException extends BaseException {
  NetworkIssueException() : super("network issue connection");
}

class HttpCallException extends BaseException {
  HttpCallException(this.error) : super("Http call exception");

  final String? error;

  bool get hasError => error != null && error!.isNotEmpty;
}

class ApiErrorException extends BaseException {
  ApiErrorException(this.error, this.httpStatusCode)
      : super("ApiErrorException $error httpCode $httpStatusCode");

  final String? error;
  final int? httpStatusCode;

  bool get hasError => error != null && error!.isNotEmpty;
}
