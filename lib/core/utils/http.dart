// Khai báo
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Http {
  final SharedPreferences _preferences;
  late Dio dio;

  Http({required SharedPreferences preferences}) : _preferences = preferences {
    dio = Dio();

    // cấu hình option
    dio.options.baseUrl = '${dotenv.env['URL']!}/v1';
    dio.options.headers['Content-Type'] = 'application/json';

    // fake access token để test
    dio.options.headers['Authorization'] =
        // sơn
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdiNjNkNmU4LTdhMWQtNGQyZS05MzZiLTk4ZjhkYTllNDcyMCIsImZpcnN0TmFtZSI6IlPGoW4iLCJsYXN0TmFtZSI6Ik5ndXnhu4VuIiwiZnVsbE5hbWUiOiJTxqFuIE5ndXnhu4VuIiwiZW1haWwiOiJzb25ubi4yMWl0QHZrdS51ZG4udm4iLCJhdmF0YXIiOiJodHRwczovL3Jlcy5jbG91ZGluYXJ5LmNvbS9hbGFuMTQxMS9pbWFnZS91cGxvYWQvdjE3Mjc4MzIyODUvY2hhdF9hcHAvcGVyeHJ5bnZxZWZpaHVta2loczkuanBnIiwiZ2VuZGVyIjoyLCJpYXQiOjE3Mjg4Nzk1NDksImV4cCI6MTc2MDQzNzE0OX0.5HQrKi5eOg3jZOhKqX_mAWFfFX2URh7IZdSaoRUBzCQ';

    // cấu hình authorization cho request
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = _preferences.getString('accessToken');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
    ));
  }
}
