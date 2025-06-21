// api_service.dart
// This file contains the core API service implementation for HTTP requests

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// ApiService is responsible for making HTTP requests to the backend
/// It handles request creation, error handling, and response parsing
class ApiServic extends GetxService {
  // Base URL for API endpoints - update this with your actual API base
  final String baseUrl = 'https://yourapibaseurl.com/api/v1';

  // Default request timeout duration
  static const int timeoutDuration = 30; // seconds

  // Authentication token storage - use this to store JWT or other tokens
  final RxString authToken = ''.obs;

  // Observable loading state that can be used across the app
  final RxBool isLoading = false.obs;

  // Observable error message
  final RxString errorMessage = ''.obs;

  /// Initialize the API service
  Future<ApiServic> init() async {
    // You can load stored tokens from secure storage here
    // Example: authToken.value = await secureStorage.read(key: 'auth_token');

   
    return this;
  }

  /// Set the authentication token (e.g., after login)
  void setToken(String token) {
    authToken.value = token;
    // You might want to save the token to secure storage
    // Example: await secureStorage.write(key: 'auth_token', value: token);
  }

  /// Clear the authentication token (e.g., after logout)
  void clearToken() {
    authToken.value = '';
    // Clear from secure storage too
    // Example: await secureStorage.delete(key: 'auth_token');
  }

  /// Helper method to create headers for requests
  Map<String, String> _getHeaders({bool requiresAuth = true}) {
    // Basic headers for JSON APIs
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authorization token if required and available
    if (requiresAuth && authToken.value.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${authToken.value}';
    }

    return headers;
  }

  /// GET request implementation
  Future<dynamic> get(String endpoint, {
    bool requiresAuth = true,
    Map<String, dynamic>? queryParams,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Build the URL with query parameters
      var uri = Uri.parse('$baseUrl$endpoint');
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      // Make the request
      final response = await http.get(
        uri,
        headers: _getHeaders(requiresAuth: requiresAuth),
      ).timeout(const Duration(seconds: timeoutDuration));

      // Process the response
      return _processResponse(response);
    } on SocketException {
      _handleError('No internet connection. Please check your network.');
      return null;
    } on TimeoutException {
      _handleError('Request timed out. Please try again.');
      return null;
    } catch (e) {
      _handleError('An unexpected error occurred: ${e.toString()}');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// POST request implementation
  Future<dynamic> post(String endpoint, dynamic body, {
    bool requiresAuth = true,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Convert body to JSON string
      final jsonBody = json.encode(body);

      // Make the request
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: jsonBody,
      ).timeout(const Duration(seconds: timeoutDuration));

      // Process the response
      return _processResponse(response);
    } on SocketException {
      _handleError('No internet connection. Please check your network.');
      return null;
    } on TimeoutException {
      _handleError('Request timed out. Please try again.');
      return null;
    } catch (e) {
      _handleError('An unexpected error occurred: ${e.toString()}');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// PUT request implementation
  Future<dynamic> put(String endpoint, dynamic body, {
    bool requiresAuth = true,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Convert body to JSON string
      final jsonBody = json.encode(body);

      // Make the request
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: jsonBody,
      ).timeout(const Duration(seconds: timeoutDuration));

      // Process the response
      return _processResponse(response);
    } on SocketException {
      _handleError('No internet connection. Please check your network.');
      return null;
    } on TimeoutException {
      _handleError('Request timed out. Please try again.');
      return null;
    } catch (e) {
      _handleError('An unexpected error occurred: ${e.toString()}');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// DELETE request implementation
  Future<dynamic> delete(String endpoint, {
    bool requiresAuth = true,
    dynamic body,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Optional body conversion
      final jsonBody = body != null ? json.encode(body) : null;

      // Make the request
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: jsonBody,
      ).timeout(const Duration(seconds: timeoutDuration));

      // Process the response
      return _processResponse(response);
    } on SocketException {
      _handleError('No internet connection. Please check your network.');
      return null;
    } on TimeoutException {
      _handleError('Request timed out. Please try again.');
      return null;
    } catch (e) {
      _handleError('An unexpected error occurred: ${e.toString()}');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// PATCH request implementation
  Future<dynamic> patch(String endpoint, dynamic body, {
    bool requiresAuth = true,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Convert body to JSON string
      final jsonBody = json.encode(body);

      // Make the request
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: jsonBody,
      ).timeout(const Duration(seconds: timeoutDuration));

      // Process the response
      return _processResponse(response);
    } on SocketException {
      _handleError('No internet connection. Please check your network.');
      return null;
    } on TimeoutException {
      _handleError('Request timed out. Please try again.');
      return null;
    } catch (e) {
      _handleError('An unexpected error occurred: ${e.toString()}');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper method to process HTTP responses
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: // OK
      case 201: // Created
      // Parse the JSON response
        try {
          return json.decode(response.body);
        } catch (e) {
          // If response is not JSON, return the raw body
          return response.body;
        }

      case 400: // Bad Request
        _handleError('Bad request: ${_parseErrorMessage(response)}');
        return null;

      case 401: // Unauthorized
        _handleError('Authentication failed. Please login again.');
        // You might want to trigger a logout or token refresh here
        clearToken();
        // Optionally navigate to login screen
        // Get.offAllNamed('/login');
        return null;

      case 403: // Forbidden
        _handleError('You do not have permission to access this resource.');
        return null;

      case 404: // Not Found
        _handleError('Resource not found.');
        return null;

      case 422: // Validation Error
        _handleError('Validation error: ${_parseErrorMessage(response)}');
        return null;

      case 500: // Server Error
      case 502: // Bad Gateway
      case 503: // Service Unavailable
        _handleError('Server error. Please try again later.');
        return null;

      default:
        _handleError('Unexpected error occurred (${response.statusCode})');
        return null;
    }
  }

  /// Helper method to parse error messages from response
  String _parseErrorMessage(http.Response response) {
    try {
      final decoded = json.decode(response.body);

      // Different APIs may structure error messages differently
      // Adjust this logic based on your API's error response structure
      if (decoded is Map) {
        // Check for common error message fields
        if (decoded.containsKey('message')) {
          return decoded['message'];
        } else if (decoded.containsKey('error')) {
          return decoded['error'];
        } else if (decoded.containsKey('errors')) {
          final errors = decoded['errors'];
          if (errors is Map) {
            // Join all error messages
            return errors.values
                .expand((e) => e is List ? e : [e.toString()])
                .join(', ');
          } else if (errors is List) {
            return errors.join(', ');
          } else {
            return errors.toString();
          }
        }
      }

      // Default fallback
      return response.body;
    } catch (e) {
      // If parsing fails, return the raw body (truncated if too long)
      final body = response.body;
      return body.length > 100 ? '${body.substring(0, 100)}...' : body;
    }
  }

  /// Helper method to handle errors
  void _handleError(String message) {
    errorMessage.value = message;

    // Optionally show a snackbar or toast
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
      colorText: Get.theme.colorScheme.onError,
    );
  }
}