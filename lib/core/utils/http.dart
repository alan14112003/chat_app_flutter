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
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ4NjdhNGE4LTBhMjItNGFmMC1hMTVjLTlkODNhNDhlMDViNCIsImZpcnN0TmFtZSI6IkFsYW4iLCJsYXN0TmFtZSI6Ik5ndXnhu4VuIiwiZnVsbE5hbWUiOiJBbGFuIE5ndXnhu4VuIiwiZW1haWwiOiJhbGFuQGdtYWlsLmNvbSIsImF2YXRhciI6Imh0dHBzOi8vcmVzLmNsb3VkaW5hcnkuY29tL2FsYW4xNDExL2ltYWdlL3VwbG9hZC92MTcyNzgzMjI4NS9jaGF0X2FwcC9wZXJ4cnludnFlZmlodW1raWhzOS5qcGciLCJnZW5kZXIiOjIsImlhdCI6MTcyOTM5ODkzOSwiZXhwIjoxNzYwOTU2NTM5fQ.74vz8nThXXkcKKp-JzxK_uy8zUUecCIoIAQAiQLQS_A';
    // lieen
    // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdiNjNkNmU4LTdhMWQtNGQyZS05MzZiLTk4ZjhkYTllNDcyMCIsImZpcnN0TmFtZSI6IlPGoW4iLCJsYXN0TmFtZSI6Ik5ndXnhu4VuIiwiZnVsbE5hbWUiOiJTxqFuIE5ndXnhu4VuIiwiZW1haWwiOiJzb25ubi4yMWl0QHZrdS51ZG4udm4iLCJhdmF0YXIiOiJodHRwczovL3Jlcy5jbG91ZGluYXJ5LmNvbS9hbGFuMTQxMS9pbWFnZS91cGxvYWQvdjE3Mjc4MzIyODUvY2hhdF9hcHAvcGVyeHJ5bnZxZWZpaHVta2loczkuanBnIiwiZ2VuZGVyIjoyLCJpYXQiOjE3MjkwMzk4MzAsImV4cCI6MTc2MDU5NzQzMH0.IyNVahzGaX_ldx8tORACiM218urbyi-lZa2iUJzMsrE';
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
