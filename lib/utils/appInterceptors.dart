import 'package:dio/dio.dart';

import '../constants/SharedPreferencesKeysConstants.dart';
import 'SharedPreferencesUtil.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors(this.dio);
  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final bearerToken = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );

    options.headers['Authorization'] = 'Bearer $bearerToken';

    return handler.next(options);
  }
}
