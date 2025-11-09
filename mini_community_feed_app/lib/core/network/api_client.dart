import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_community_feed_app/errors/http_exception.dart';

class ApiClient {
  /// [client] - An instance of `http.Client` used for making HTTP requests.
  final http.Client client;

  ApiClient(this.client);

  /// The base URL for the API.
  String get baseUrl =>
      'https://jsonplaceholder.typicode.com'; // Default base URL

  /// Performs an HTTP GET request to the specified [endpoint].
  /// [endpoint] - The API endpoint to send the GET request to.
  /// [headers] - Optional headers to include in the request.
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    return await _sendRequest('GET', endpoint, headers: headers);
  }

  /// Performs an HTTP POST request to the specified [endpoint].
  /// [endpoint] - The API endpoint to send the POST request to.
  /// [headers] - Optional headers to include in the request.
  /// [body] - Optional body to include in the POST request.
  Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    return await _sendRequest('POST', endpoint, headers: headers, body: body);
  }

  /// Performs an HTTP PUT request to the specified [endpoint].
  /// [endpoint] - The API endpoint to send the PUT request to.
  /// [headers] - Optional headers to include in the request.
  /// [body] - Optional body to include in the PUT request.
  Future<dynamic> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    return await _sendRequest('PUT', endpoint, headers: headers, body: body);
  }

  /// Performs an HTTP DELETE request to the specified [endpoint].
  /// [endpoint] - The API endpoint to send the DELETE request to.
  /// [headers] - Optional headers to include in the request.
  Future<dynamic> delete(String endpoint,
      {Map<String, String>? headers}) async {
    return await _sendRequest('DELETE', endpoint, headers: headers);
  }

  /// Sends an HTTP request with the specified [method] to the given [endpoint].
  /// [method] - The HTTP method to use (GET, POST, PUT, DELETE).
  /// [endpoint] - The API endpoint to send the request to.
  /// [headers] - Optional headers to include in the request.
  /// [body] - Optional body to include in the request.
  Future<dynamic> _sendRequest(String method, String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    if (headers == null) {
      headers = {
        'Content-Type': 'application/json',
      };
    } else {
      headers['Content-Type'] = 'application/json';
    }

    final fullUrl = Uri.parse('$baseUrl$endpoint');

    try {
      final response =
          await _makeRequest(method, fullUrl, headers: headers, body: body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        _checkException(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Makes an HTTP request with the specified [method] to the given [url].
  /// [method] - The HTTP method to use (GET, POST, PUT, DELETE).
  /// [url] - The full URL to send the request to.
  /// [headers] - Optional headers to include in the request.
  /// [body] - Optional body to include in the request.
  Future<http.Response> _makeRequest(String method, Uri url,
      {Map<String, String>? headers, dynamic body}) {
    switch (method) {
      case 'GET':
        return client.get(url, headers: headers);
      case 'POST':
        return client.post(url, headers: headers, body: json.encode(body));
      case 'PUT':
        return client.put(url, headers: headers, body: json.encode(body));
      case 'DELETE':
        return client.delete(url, headers: headers);
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
  }

  /// Checks the response and throws specific HTTP exceptions based on the status code.
  /// [response] - The HTTP response to check.
  /// Throws specific HTTP exceptions such as `HttpBadRequest`, `HttpUnauthorized`,
  /// or `HttpNotFound` based on the status code and message in the response body.
  void _checkException(http.Response response) {
    Map<String, dynamic> errorResponse = jsonDecode(response.body);
    final message = errorResponse['message'];
    final code = errorResponse['status'];
    switch (response.statusCode) {
      case 400:
        throw HttpBadRequest(message: message, errorCode: code.toString());
      case 401:
        throw HttpUnauthorized(message: message, errorCode: code.toString());
      case 404:
        throw HttpNotFound(message: message, errorCode: code.toString());
      default:
        throw HttpNotFound(
            message: message, errorCode: response.statusCode.toString());
    }
  }
}
