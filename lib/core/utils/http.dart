// Khai báo
import 'package:chat_app_flutter/features/auth/data/sources/auth_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Http {
  final AuthLocalDataSource _authLocalDataSource;
  late Dio dio;

  Http({
    required AuthLocalDataSource authLocalDataSource,
  }) : _authLocalDataSource = authLocalDataSource {
    dio = Dio();

    // cấu hình option
    dio.options.baseUrl = '${dotenv.env['URL']!}/v1';
    dio.options.headers['Content-Type'] = 'application/json';

    // cấu hình authorization cho request
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = _authLocalDataSource.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
    ));
  }
}
