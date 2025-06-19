import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../Base/model/response/base_response.dart';
import '../main.dart';
import '../utils/appInterceptors.dart';
import '../utils/fluttertoast.dart';
import 'api_end_point.dart';

enum HttpRequestType {
  get,
  post,
  delete,
  put, // ✅ added
}

class DioUtil {
  static const bool enableLogger = true;
  static final Dio _dio = _create();

  static Dio _create() {
    final options = BaseOptions(
      baseUrl: APIEndPoints.baseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout:
          kIsWeb ? null : const Duration(seconds: 15), // Only set on non-web
    );

    final dio = Dio(options);
    dio.interceptors.addAll([AppInterceptors(dio)]);

    return dio;
  }

  // Add this to your DioUtil class if not already present
  static Future<Map<String, dynamic>> simpleRequest({
    required String endpoint,
    required Map<String, dynamic> requestBody,
    required HttpRequestType httpRequestType,
  }) async {
    final dio = Dio();

    try {
      final response = await dio.request(
        endpoint,
        data: requestBody,
        options: Options(
          method: httpRequestType == HttpRequestType.post ? 'POST' : 'GET',
          headers: {"Content-Type": "application/json"},
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // It was a 400/401/403/etc
        return {
          "success": false,
          "message": response.data['message'] ?? 'Authentication failed',
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Something went wrong during login.",
      };
    }
  }

  static Future<BaseResponse<T>> request<T>({
    String? item,
    String? loadingText,
    bool showError = true,
    bool showLoading = true,
    required String endpoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? requestBody,
    required HttpRequestType httpRequestType,
    required dynamic Function(Map<String, dynamic> json) fromJsonT,
    T Function(Object)? cast,
  }) async {
    Response<dynamic> response;
    late String errorMessage;
    String path = item != null ? '$endpoint/$item' : endpoint;

    try {
      toggleLoader(true);
      requestBody ??= {};
      switch (httpRequestType) {
        case HttpRequestType.get:
          response = await _dio.get(path, queryParameters: params);
          break;
        case HttpRequestType.post:
          if (requestBody.containsKey('doc') && requestBody['doc'] != null) {
            response = await handleMultipleImages(
              path: path,
              requestBody: requestBody,
            );
          } else {
            response = await _dio.post(
              path,
              data: requestBody,
              queryParameters: params,
            );
          }
          break;
        case HttpRequestType.put: // ✅ new put case
          response = await _dio.put(
            path,
            data: requestBody,
            queryParameters: params,
          );
          break;
        case HttpRequestType.delete:
          response = await _dio.delete(
            path,
            data: requestBody,
            queryParameters: params,
          );
          break;
      }

      late final BaseResponse<T> baseResponse;
      toggleLoader(false);
      if (response.data is Map<String, dynamic>) {
        baseResponse = BaseResponse<T>.fromJson(
          response.data as Map<String, dynamic>,
          (json) {
            if (json is List) {
              final list =
                  json
                      .map((e) => fromJsonT(e as Map<String, dynamic>))
                      .toList();
              return cast != null ? cast(list) : list as T;
            } else {
              return fromJsonT(json as Map<String, dynamic>);
            }
          },
        );
      } else if (response.data is List) {
        // ✅ Wrap response in Map and pass entire List directly to the callback
        baseResponse = BaseResponse<T>.fromJson(
          {'data': response.data}, // fake wrapping
          (json) {
            final list =
                (json as List)
                    .map((e) => fromJsonT(e as Map<String, dynamic>))
                    .toList();
            return cast != null ? cast(list) as T : list as T;
          },
        );
      } else {
        throw Exception(
          'Unsupported response format: ${response.data.runtimeType}',
        );
      }

      // final baseResponse = BaseResponse<T>.fromJson(
      //
      //   response.data  ,
      //   // as Map<String, dynamic>,
      //       (json) {
      //
      //     if (json is List) {
      //       final list = json.map((e) => fromJsonT(e as Map<String, dynamic>)).toList();
      //       return cast != null ? cast(list) as T : list as T;
      //     } else {
      //
      //       return fromJsonT(json as Map<String, dynamic>);
      //     }
      //   },
      // );

      if (!baseResponse.success!) {
        return BaseResponse(
          success: false,
          message: response.statusMessage ?? 'Request failed',
        );
      }

      return baseResponse;
    } on DioException catch (e) {
      toggleLoader(false);
      errorMessage = e.message ?? 'An error occurred';

      if (!e.response!.data["success"]) {
        return BaseResponse(
          success: false,
          message: e.response!.data["message"] ?? 'Request failed',
        );
      }
      if (e.response != null) {
        final res = e.response!;
        final statusCode = res.statusCode ?? 0;

        errorMessage = res.statusMessage ?? errorMessage;

        if (statusCode == 400 && res.data is Map<String, dynamic>) {
          toggleLoader(false);
          final message = res.data['message'];
          if (message is List) {
            errorMessage = message.join(' ');
          } else {
            errorMessage = message?.toString() ?? errorMessage;
          }
        }

        if (enableLogger) {
          toggleLoader(false);
       
        }

        if (res.statusMessage == "Found") {
          errorMessage = "Unexpected Error Occurred";
        }
      } else {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = 'Connection timeout. Please check your internet';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = 'Send timeout. Please check your internet';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Receive timeout. Please check your internet';
            break;
          case DioExceptionType.connectionError:
            errorMessage = 'Connection error. Please check your internet';
            break;
          default:
            errorMessage = e.message ?? 'Unexpected error occurred';
        }

        if (enableLogger) {
        }
      }
    } catch (e) {
      toggleLoader(false);
      errorMessage = e.toString();
      FlutterToastUtil.showToast(text: errorMessage);
    }

    return BaseResponse(success: false, message: errorMessage);
  }

  static Future<Response<dynamic>> handleMultipleImages({
    required String path,
    Map<String, dynamic>? params,
    required Map<String, dynamic> requestBody,
  }) async {
    final formData = FormData();

    final leaveHistoryDocuments = requestBody['LeaveHistoryDocument'];
    if (leaveHistoryDocuments is List) {
      for (int i = 0; i < leaveHistoryDocuments.length; i++) {
        final docPath = leaveHistoryDocuments[i]['document'];
        if (docPath != null) {
          formData.files.add(
            MapEntry(
              'LeaveHistoryDocument[$i][document]',
              await MultipartFile.fromFile(docPath),
            ),
          );
        }
      }
    }

    final leaveDates = requestBody['LeaveDate'];
    if (leaveDates is List) {
      for (int i = 0; i < leaveDates.length; i++) {
        formData.fields.add(
          MapEntry('LeaveDate[$i][from]', leaveDates[i]['from']),
        );
        formData.fields.add(MapEntry('LeaveDate[$i][to]', leaveDates[i]['to']));
      }
    }

    requestBody.forEach((key, value) {
      if (key != 'LeaveHistoryDocument' && key != 'LeaveDate') {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });


    return await _dio.post(path, data: formData, queryParameters: params);
  }
}
