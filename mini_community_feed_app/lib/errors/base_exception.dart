/// A base class for custom exceptions in the application.
class BaseException implements Exception {

  /// A descriptive message explaining the exception.
  final String message;
  const BaseException({required this.message});

  @override
  String toString() {
    // Provides a string representation of the exception including its type, code, and message.
    return "$runtimeType :$message";
  }
}
