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
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ4NjdhNGE4LTBhMjItNGFmMC1hMTVjLTlkODNhNDhlMDViNCIsImZpcnN0TmFtZSI6IkFsYW4iLCJsYXN0TmFtZSI6Ik5ndXnhu4VuIiwiZnVsbE5hbWUiOiJBbGFuIE5ndXnhu4VuIiwiZW1haWwiOiJhbGFuQGdtYWlsLmNvbSIsImF2YXRhciI6bnVsbCwiZ2VuZGVyIjoyLCJpYXQiOjE3MjY0NDY2MTcsImV4cCI6MTc1ODAwNDIxN30.6ttfabLRRCvCFpDtAKH5Ooama3Ty7EH6DzN8_45-hf4';

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
