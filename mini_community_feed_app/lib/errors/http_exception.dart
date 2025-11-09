import 'package:mini_community_feed_app/errors/base_exception.dart';

/// A base class for HTTP-related exceptions.
///
/// This class extends `BaseException` to provide a base exception type specifically
/// for HTTP errors. It includes the HTTP status code and error message.
class HttpException extends BaseException {
  /// Creates an instance of `HttpException`.
  ///
  /// [code] - The HTTP status code associated with the exception.
  /// [message] - The error message describing the exception.
  const HttpException({required super.message});
}

/// An exception indicating a failure in the HTTP request.
class HttpRequestFailure extends HttpException {
  /// The error code associated with the HTTP request failure.
  final String errorCode;

  /// Creates an instance of `HttpRequestFailure`.

  HttpRequestFailure({required super.message, required this.errorCode});
}

/// An exception indicating a bad HTTP request (400 status code).
class HttpBadRequest extends HttpException {
  /// The error code associated with the bad HTTP request.
  final String errorCode;

  /// Creates an instance of `HttpBadRequest`.
  const HttpBadRequest({required super.message, required this.errorCode});
}

/// An exception indicating an unauthorized HTTP request (401 status code).
class HttpUnauthorized extends HttpException {
  /// The error code associated with the unauthorized HTTP request.
  final String errorCode;

  /// Creates an instance of `HttpUnauthorized`.
  const HttpUnauthorized({required super.message, required this.errorCode});
}

/// An exception indicating a not found HTTP request (404 status code).
class HttpNotFound extends HttpException {
  /// The error code associated with the not found HTTP request.
  final String errorCode;
  const HttpNotFound({required super.message, required this.errorCode});
}
