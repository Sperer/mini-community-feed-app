import 'package:mini_community_feed_app/errors/base_exception.dart';

class AppException extends BaseException {
  const AppException({required super.message});
}

/// An exception indicating an unknown error occurred.
class UnknownException extends AppException {
  /// Creates an instance of `UnknownException` with a default message and code.
  UnknownException() : super(message: 'Something Went Wrong!');
}

/// An exception indicating that there is no internet connection.
class NoInternetException extends AppException {
  /// Creates an instance of `NoInternetException` with a default message and code.
  NoInternetException()
      : super(
          message: 'Device is not connected to the internet',
        );
}
